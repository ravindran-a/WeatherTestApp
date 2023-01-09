//
//  WeatherInfoCell.swift
//  WeatherTestApp
//
//  Created by Ravindran on 02/01/23.
//

import UIKit

class WeatherInfoCell: UITableViewCell {
    
    static let cellIdentifier: String = AppStrings.weatherInfoCellIdentifier.rawValue
    
    private lazy var containerView: UIView = UIFactory.getView(id: AppAccessibilityIdentifiers.containerView.rawValue)
    private lazy var cityName: UILabel = UIFactory.getLabel(id: AppAccessibilityIdentifiers.cityName.rawValue)
    private lazy var cityTemperature: UILabel = UIFactory.getLabel(id: AppAccessibilityIdentifiers.cityTemperature.rawValue)
    private lazy var currentWeatherIcon: UIImageView = UIFactory.getImageView(id: AppAccessibilityIdentifiers.currentWeatherIcon.rawValue)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadCellComponents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func loadCellComponents() {
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
