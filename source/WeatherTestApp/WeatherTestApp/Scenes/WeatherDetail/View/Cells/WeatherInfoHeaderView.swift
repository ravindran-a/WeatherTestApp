//
//  WeatherInfoHeaderView.swift
//  WeatherTestApp
//
//  Created by Ravindran on 19/12/22.
//

import UIKit

class WeatherInfoHeaderView: UITableViewHeaderFooterView {
    
    static let identifier: String = AppStrings.weatherInfoHeaderIdentifier.rawValue
    
    private lazy var containerView: UIView = UIFactory.getView(id: AppAccessibilityIdentifiers.containerView.rawValue)
    private lazy var cityName: UILabel = UIFactory.getLabel(id: AppAccessibilityIdentifiers.cityName.rawValue)
    private lazy var cityTemperature: UILabel = UIFactory.getLabel(id: AppAccessibilityIdentifiers.cityTemperature.rawValue)
    private lazy var currentWeatherIcon: UIImageView = UIFactory.getImageView(id: AppAccessibilityIdentifiers.currentWeatherIcon.rawValue)
    
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
            make.leading.equalToSuperview().offset(AppLayoutOffsetValues.defaultMarginOffset.rawValue)
            make.top.equalToSuperview().offset(AppLayoutOffsetValues.defaultMarginOffset.rawValue)
        }
        cityName.font = UIFont.systemFont(ofSize: AppFontSizes.cellTitleFontSize.rawValue, weight: .semibold)
        cityName.textColor = UIColor.black
        
        containerView.addSubview(cityTemperature)
        cityTemperature.snp.makeConstraints { make in
            make.top.equalTo(cityName.snp.bottom)
            make.leading.equalToSuperview().offset(AppLayoutOffsetValues.defaultMarginOffset.rawValue)
            make.bottom.equalToSuperview().offset(-AppLayoutOffsetValues.defaultMarginOffset.rawValue)
        }
        cityTemperature.font = UIFont.systemFont(ofSize: AppFontSizes.cellDetailFontSize.rawValue, weight: .regular)
        cityTemperature.textColor = UIColor.darkGray
        
        containerView.addSubview(currentWeatherIcon)
        currentWeatherIcon.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-AppLayoutOffsetValues.defaultMarginOffset.rawValue)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(AppLayoutOffsetValues.iconWidthHeight.rawValue)
        }
    }
    
    func configureData(cityName: String?, temperature: String?, icon: UIImage?) {
        self.cityName.text = cityName
        cityTemperature.text = temperature
        currentWeatherIcon.image = icon
    }
}
