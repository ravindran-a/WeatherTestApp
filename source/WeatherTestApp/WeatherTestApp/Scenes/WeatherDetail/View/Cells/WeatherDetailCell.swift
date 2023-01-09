//
//  WeatherDetailCell.swift
//  WeatherTestApp
//
//  Created by Ravindran on 19/12/22.
//

import UIKit

class WeatherDetailCell: UITableViewCell {
    
    static let cellIdentifier: String = AppStrings.weatherDetailCellIdentifier.rawValue
    
    private lazy var containerView: UIView = UIFactory.getView(id: AppAccessibilityIdentifiers.containerView.rawValue)
    private lazy var time: UILabel = UIFactory.getLabel(id: AppAccessibilityIdentifiers.time.rawValue)
    private lazy var temperature: UILabel = UIFactory.getLabel(id: AppAccessibilityIdentifiers.temperature.rawValue)
    
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
            make.height.equalTo(AppLayoutOffsetValues.iconWidthHeight.rawValue)
        }
        containerView.addSubview(time)
        time.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(AppLayoutOffsetValues.defaultMarginOffset.rawValue)
            make.centerY.equalToSuperview()
        }
        time.font = UIFont.systemFont(ofSize: AppFontSizes.cellDetailFontSize.rawValue, weight: .semibold)
        time.textColor = UIColor.black
        
        containerView.addSubview(temperature)
        temperature.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-AppLayoutOffsetValues.defaultMarginOffset.rawValue)
            make.centerY.equalToSuperview()
        }
        temperature.font = UIFont.systemFont(ofSize: AppFontSizes.cellDetailFontSizeSmall.rawValue, weight: .regular)
        temperature.textColor = UIColor.darkGray
    }
    
    func configureData(time: String?, temperature: String?) {
        self.time.text = time
        self.temperature.text = temperature
    }
}
