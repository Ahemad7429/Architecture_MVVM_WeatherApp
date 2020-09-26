//
//  HomeViewController.swift
//  Architecture_MVVM
//
//  Created by AhemadAbbas on 24/09/20.
//  Copyright © 2020 AhemadAbbas. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    
    // MARK:- Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- Variables
    
    var viewModel = HomeViewModel()
    var refreshControl = UIRefreshControl()
    
    
    // MARK:- View Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
    }
    
    // MARK:- Actions
    
    @IBAction func addButtonWasTapped(_ sender: UIButton) {
        let locationPickerViewController = LocationPickerViewController.instantiateFrom(appStoryboard: .locationPicker)
        locationPickerViewController.delegate = self
        presentViewController(locationPickerViewController)
    }
    
    // MARK:- Functions
    
    private func initialSetUp() {
        registerTableViewCells()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refreshLocations), for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.allowsMultipleSelectionDuringEditing = false
        updateLocationTable()
    }
    
    private func registerTableViewCells() {
        tableView.register(HomeWeatherTableViewCell.self)
    }
    
    @objc private func refreshLocations() {
        viewModel.locationPlaces?.removeAll()
        tableView.reloadData()
        updateLocationTable()
        refreshControl.endRefreshing()
    }
    
    private func updateLocationTable() {
        if let locations = LocalStorageManager.getLocations(), locations.count > 0 {
            viewModel.locationPlaces = locations
        }
        tableView.reloadData()
    }
    
    private func navigateToCityDetail(details: WeatherModel, localLocation: LocalLocation, selectedIndex: Int) {
        let cityDetailController = CityDetailsViewController.instantiateFrom(appStoryboard: .main)
        cityDetailController.viewModel.weatherDetails = details
        cityDetailController.viewModel.localLocation = localLocation
        cityDetailController.viewModel.selectedIndex = selectedIndex
        pushViewController(cityDetailController)
    }
    
}

// MARK:- UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.locationPlaces?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weatherCell = tableView.dequeueReusableCell(withIdentifier: HomeWeatherTableViewCell.reuseIdentifier, for: indexPath) as? HomeWeatherTableViewCell else {
            return UITableViewCell()
        }
        if let location = viewModel.locationPlaces?[indexPath.row] {
            weatherCell.configureCell(location: location)
        }
        return weatherCell
    }
    
}

// MARK:- UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? HomeWeatherTableViewCell else {
            return
        }
        if let weatherDetails = cell.weatherModel {
            cell.setupTransistionData(index: indexPath.row)
            navigateToCityDetail(details: weatherDetails, localLocation: cell.localLocation, selectedIndex: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            LocalStorageManager.remove(location: viewModel.locationPlaces![indexPath.row])
            viewModel.locationPlaces?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension HomeViewController: LocationPickerDelegate {
    
    func locationPickerDidAddLocations() {
        updateLocationTable()
    }
    
}
