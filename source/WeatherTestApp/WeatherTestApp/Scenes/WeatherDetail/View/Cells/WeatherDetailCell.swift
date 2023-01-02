//
//  WeatherDetailCell.swift
//  SysvineWeatherApp
//
//  Created by Ravindran on 19/12/22.
//

import UIKit

class WeatherDetailCell: UITableViewCell {

    static let cellIdentifier: String = "WeatherDetailCell"
    
    lazy var containerView: UIView = UIFactory.getView(id: "containerView")
    lazy var time: UILabel = UIFactory.getLabel(id: "time")
    lazy var temperature: UILabel = UIFactory.getLabel(id: "temperature")
    
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

    func loadCellComponents() {
        contentView.backgroundColor = .white
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
            make.height.equalTo(44.0)
        }
        containerView.addSubview(time)
        time.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        time.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        time.textColor = UIColor.black
        
        containerView.addSubview(temperature)
        temperature.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        temperature.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        temperature.textColor = UIColor.darkGray
    }

}
