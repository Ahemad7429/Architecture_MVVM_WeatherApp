//
//  CityDetailsViewController.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 25/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import UIKit

class CityDetailsViewController: BaseViewController {
    
    // MARK:- Outlets
    
    @IBOutlet weak var navTitleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minMaxTempLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var forecastCollectionView: UICollectionView!
    
    // MARK:- Variables
    
    var viewModel = CityDetailsViewModel()
    
    // MARK:- View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    // MARK:- Actions
    
    @IBAction func closebuttnWasTapped(_ sender: UIButton) {
        popViewController()
    }

    // MARK:- Functions
    
    private func initialSetup() {
        configureTransistion()
        configureView()
        getForecastDetails()
    }
    
    private func configureTransistion() {
        navTitleLabel.hero.id = "h_city_\(viewModel.selectedIndex)"
        weatherTypeLabel.hero.id = "h_weatherType_\(viewModel.selectedIndex)"
        temperatureLabel.hero.id = "h_temperature_\(viewModel.selectedIndex)"
        weatherImageView.hero.id = "h_weatherImage_\(viewModel.selectedIndex)"
        navTitleLabel.hero.modifiers = [.arc]
        weatherTypeLabel.hero.modifiers = [.arc]
        temperatureLabel.hero.modifiers = [.arc]
        weatherImageView.hero.modifiers = [.arc]
    }
        
    private func configureView() {
        forecastCollectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        forecastCollectionView.register(ForecastListCollectionViewCell.self)
        setUI()
    }
    
    private func setUI() {
        navTitleLabel.text = viewModel.localLocation.cityName
        temperatureLabel.text = viewModel.weatherDetails.main?.temp?.getTemperatureString()
        weatherTypeLabel.text = viewModel.weatherDetails.weather?.first?.weatherDescription?.capitalized
        weatherImageView.image = WeatherTypes(rawValue: viewModel.weatherDetails.weather?.first?.weatherDescription ?? "")?.icon ?? UIImage(named: "img_cloud_day")
        let maxTemp = (viewModel.weatherDetails.main?.tempMax ?? 273.15).getTemperatureString()
        let minTemp = (viewModel.weatherDetails.main?.tempMin ?? 273.15).getTemperatureString()
        minMaxTempLabel.text = "\(minTemp)/\(maxTemp)"
        windSpeedLabel.text = (viewModel.weatherDetails.wind?.speed ?? 0).toKphString()
        humidityLabel.text = "\(viewModel.weatherDetails.main?.humidity ?? 0)%"
        sunriseLabel.text = viewModel.weatherDetails.sys?.sunrise?.convertToDayTime()
        sunsetLabel.text = viewModel.weatherDetails.sys?.sunset?.convertToDayTime()
        pressureLabel.text = "\((viewModel.weatherDetails.main?.pressure ?? 0).rounded(toPlaces: 1)) hPa"
    }
    
    private func getForecastDetails() {
        showHUD()
        viewModel.getWeatherForcastData(success: {
            self.dismissHUD()
            self.updateDataForForecast()
        }) { (erorMessage) in
            self.dismissHUD()
            self.showAlert(errorMsg: erorMessage)
        }
    }
    
    private func updateDataForForecast() {
        guard let forecastDetails = viewModel.weatherForecastDetails else { return }
        guard let forecastList = forecastDetails.list, forecastList.count > 0 else { return }
        let maxTemp = (forecastList.compactMap { $0.main?.tempMax }.max() ?? 273.15).getTemperatureString()
        let minTemp = (forecastList.compactMap { $0.main?.tempMin }.min() ?? 273.15).getTemperatureString()
        minMaxTempLabel.text = "\(minTemp)/\(maxTemp)"
        forecastCollectionView.dataSource = self
        forecastCollectionView.reloadData()
    }
}

// MARK:- 
extension CityDetailsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.weatherForecastDetails?.list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastListCollectionViewCell.reuseIdentifier, for: indexPath) as? ForecastListCollectionViewCell else { return UICollectionViewCell() }
        cell.weatherDetails = viewModel.weatherForecastDetails!.list![indexPath.row]
        return cell
    }
    
}

extension CityDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

