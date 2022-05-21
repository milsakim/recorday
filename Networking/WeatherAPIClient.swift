//
//  WeatherAPIClient.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/05/05.
//

import UIKit
import CoreLocation

enum APIError: Error {
    case httpError
    case decodingError
    case error
    case noDataError
}

struct WeatherAPIClient {
    
    private static let baseURLString: String = "https://api.openweathermap.org/data/2.5/onecall?"
    private static let appKey: String = "35ec455f68e67138f01a758d471cf357"
    
    static func fetchWeatherDataForSevenDays(of location: CLLocation,handler: @escaping (Result<WeatherAPIResponse, APIError>) -> Void) {
        let urlString: String = baseURLString + "lat=" + "\(location.coordinate.latitude)" + "&lon=" + "\(location.coordinate.longitude)" + "&exclude=current,minutely,hourly,alerts&appid=" + appKey
        print(urlString)
        guard let url: URL = URL(string: urlString) else {
            return
        }
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            print("Thread!!!! : \(Thread.current)")
            if error != nil {
                handler(.failure(.error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                handler(.failure(.httpError))
                return
            }
            
            guard let data = data else {
                handler(.failure(.noDataError))
                return
            }
            
            guard let decodedData: WeatherAPIResponse = try? JSONDecoder().decode(WeatherAPIResponse.self, from: data) else {
                handler(.failure(.decodingError))
                return
            }
            
            handler(.success(decodedData))
        }
        
        task.resume()
    }
    
}
