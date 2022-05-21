//
//  RecordListVC+CLLocationManagerDelegate.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/05/05.
//

import UIKit
import CoreLocation

extension RecordListViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("--- Location Updated: \(locations) ---")
        let currentCoordinate: CLLocationCoordinate2D = locations[0].coordinate
        
        let latitude: Double = UserDefaults.standard.double(forKey: UserDefaultsKey.latitude)
        let longitude: Double = UserDefaults.standard.double(forKey: UserDefaultsKey.longitude)
        
        if latitude == currentCoordinate.latitude && longitude == currentCoordinate.longitude {
            print("--- Location exists ---")
            return
        }
        
        UserDefaults.standard.set(currentCoordinate.latitude, forKey: UserDefaultsKey.latitude)
        UserDefaults.standard.set(currentCoordinate.longitude, forKey: UserDefaultsKey.longitude)
        
        WeatherAPIClient.fetchWeatherDataForSevenDays(of: locations[0]) { [unowned self] result in
            print("--- Handler Thread: \(Thread.current) ---")
            switch result {
            case .success(let data):
                print("--- \(Date(timeIntervalSince1970: data.daily[0].dt)) ---")
                
                // DB에 날씨 관련 데이터를 저장한다.
                DispatchQueue.main.async {
                    self.addWeatherData(data.daily)
                }
            case .failure(let error):
                print("--- Error: \(error) ---")
            }
        }
    }
    
}

