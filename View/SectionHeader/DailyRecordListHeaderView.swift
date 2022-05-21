//
//  DailyRecordListHeaderView.swift
//  Recorday
//
//  Created by HyeeJee Kim on 2022/03/25.
//

import UIKit

class DailyRecordListHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Reuse Identidifier
    
    static let reuseID: String = "DailyRecordListHeaderView"
    
    // MARK: - Property

    var dateLabel: UILabel?
    var temperaturesLabel: UILabel?
    var weatherImageView: UIImageView?

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        print("--- DailyRecordListHeaderView deinit ---")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
//        self.setBackgroundColor()
    }
    
    private func configureContents() {
        self.setBackgroundColor()
        
        if dateLabel == nil {
            dateLabel = UILabel()
            dateLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 14)
            dateLabel?.textColor = UIColor(named: "main-color")
            dateLabel?.backgroundColor = .clear
        }
        
        if temperaturesLabel == nil {
            temperaturesLabel = UILabel()
            temperaturesLabel?.backgroundColor = .clear
        }
        
        if weatherImageView == nil {
            weatherImageView = UIImageView()
            weatherImageView?.backgroundColor = .clear
        }
        
        dateLabel?.translatesAutoresizingMaskIntoConstraints = false
        temperaturesLabel?.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView?.translatesAutoresizingMaskIntoConstraints = false
        
        guard let dateLabel = dateLabel, let temperaturesLabel = temperaturesLabel, let weatherImageView = weatherImageView else {
            return
        }
        
        contentView.addSubview(dateLabel)
        contentView.addSubview(temperaturesLabel)
        contentView.addSubview(weatherImageView)
        
        NSLayoutConstraint.activate([
            dateLabel.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: temperaturesLabel.trailingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            temperaturesLabel.centerYAnchor.constraint(equalTo: weatherImageView.centerYAnchor),
            temperaturesLabel.trailingAnchor.constraint(equalTo: weatherImageView.leadingAnchor, constant: -4)
        ])
        
        NSLayoutConstraint.activate([
            weatherImageView.heightAnchor.constraint(equalToConstant: 30),
            weatherImageView.widthAnchor.constraint(equalToConstant: 30),
            weatherImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 0),
            weatherImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            weatherImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    func setBackgroundColor() {
        self.contentView.backgroundColor = UIColor(named: "accent-color")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        weatherImageView?.image = nil
    }
    
}
