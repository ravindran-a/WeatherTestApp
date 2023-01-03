//
//  WeatherInfoHeaderView.swift
//  WeatherTestApp
//
//  Created by Ravindran on 19/12/22.
//

import UIKit

class WeatherInfoHeaderView: UITableViewHeaderFooterView {
    
    static let identifier: String = "WeatherInfoHeaderView"
    
    private lazy var containerView: UIView = UIFactory.getView(id: "containerView")
    private lazy var cityName: UILabel = UIFactory.getLabel(id: "cityName")
    private lazy var cityTemperature: UILabel = UIFactory.getLabel(id: "cityTemperature")
    private lazy var currentWeatherIcon: UIImageView = UIFactory.getImageView(id: "currentWeatherIcon")
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        loadHeaderComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadHeaderComponents() {
        contentView.backgroundColor = .white
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        containerView.addSubview(cityName)
        cityName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(16)
        }
        cityName.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        cityName.textColor = UIColor.black
        
        containerView.addSubview(cityTemperature)
        cityTemperature.snp.makeConstraints { make in
            make.top.equalTo(cityName.snp.bottom)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        cityTemperature.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        cityTemperature.textColor = UIColor.darkGray
        
        containerView.addSubview(currentWeatherIcon)
        currentWeatherIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(44)
        }
    }
    
    func configureData(cityName: String?, temperature: String?, icon: UIImage?) {
        self.cityName.text = cityName
        cityTemperature.text = temperature
        currentWeatherIcon.image = icon
    }
}
