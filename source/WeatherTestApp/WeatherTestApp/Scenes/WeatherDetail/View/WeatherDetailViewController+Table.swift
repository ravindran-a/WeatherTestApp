//
//  WeatherDetailViewController+Table.swift
//  WeatherTestApp
//
//  Created by Ravindran on 04/01/23.
//

import Foundation
import UIKit

extension WeatherDetailViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: WeatherInfoHeaderView.identifier) as? WeatherInfoHeaderView {
            view.configureData(cityName: viewModel.getCityName(), temperature: viewModel.getCityTemperature(), icon: viewModel.getCurrentWeatherIcon())
            return view
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDetailCell.cellIdentifier, for: indexPath) as? WeatherDetailCell {
            cell.configureData(time: viewModel.getTime(indexPath.row), temperature: viewModel.getTemperature(indexPath.row))
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
