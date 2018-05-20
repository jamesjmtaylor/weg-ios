//
//  EquipmentCollectionViewController.swift
//  weg-ios
//
//  Created by Taylor, James on 4/29/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import UIKit

class EquipmentCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UITabBarControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var allEquipment = [Equipment]()
    var equipment = [Equipment]()
    var searchedEquipment = [Equipment]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self     
    }
    override func viewDidLayoutSubviews() {
        setupCollectionViewLayout()
        getEquipment()
    }
    var sideSize: CGFloat = 0
    func setupCollectionViewLayout(){
        sideSize = (collectionView.bounds.width ) / 3
        collectionViewFlowLayout.itemSize = CGSize(width: sideSize, height: sideSize)
        collectionViewFlowLayout.minimumLineSpacing = 0
        collectionViewFlowLayout.minimumInteritemSpacing = 0
    }
    var spinner : UIActivityIndicatorView?
    func getEquipment(){
        let storedEquipment = EquipmentRepository.getEquipment { (fetchedEquipment, error) in
            DispatchQueue.main.async {
                self.spinner?.stopAnimating()
                if let errorString = error {
                    self.presentAlert(alert: errorString)
                } else if let e = fetchedEquipment {
                    self.allEquipment = e
                    self.filterTypeToSelectedTab()
                }
            }
        }
        guard let unwrappedEquipment = storedEquipment else {
            spinner = self.view.getAndStartActivityIndicator();return
        }
        allEquipment = unwrappedEquipment
        filterTypeToSelectedTab()
        collectionView.reloadData()
    }
    // MARK: - Filter Equipment Type
    func filterTypeToSelectedTab(){
        guard let tabBar = UIApplication.shared.keyWindow?.rootViewController
            as? UITabBarController else {return}
        guard let selectedTab = tabBar.selectedViewController else {return}
        switch selectedTab.restorationIdentifier {
        case LandNavController: self.setEquipmentToLand()
        case AirNavController: self.setEquipmentToAir()
        case SeaNavController: self.setEquipmentToSea()
        default: return}//Do nothing
    }

    // MARK: - Navigation
    private let equipmentSegue = "showEquipmentSegue"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == equipmentSegue {
            guard let nav = segue.destination as? UINavigationController else {return}
            guard let dest = nav.topViewController as? EquipmentViewController else {return}
            let index = sender as! Int
            let item = (searchActive) ? searchedEquipment[index] : equipment[index]
            dest.equipmentToView = item
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }

    let LandNavController = "LandNavController"
    let AirNavController = "AirNavController"
    let SeaNavController = "SeaNavController"
    func setEquipmentToLand(){
        self.equipment = self.allEquipment.filter({ (e) -> Bool in
            return e.type == EquipmentType.LAND || e.type == EquipmentType.GUN
        })
        collectionView.reloadData()
    }
    func setEquipmentToAir(){
        self.equipment =
            self.allEquipment.filter { (e) -> Bool in return e.type == EquipmentType.AIR}
        collectionView.reloadData()
    }
    func setEquipmentToSea(){
        self.equipment =
            self.allEquipment.filter { (e) -> Bool in return e.type == EquipmentType.SEA}
        collectionView.reloadData()
    }
    // MARK: - UICollectionViewDataSource
    private let reuseIdentifier = "EquipmentCollectionViewCell"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (searchActive) ? searchedEquipment.count : equipment.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! EquipmentCollectionViewCell
        let e = (searchActive) ? searchedEquipment[indexPath.row] : equipment[indexPath.row]
        cell.configure(e: e)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: equipmentSegue, sender: indexPath.row)
    }
    
    // MARK: - SearchBar
    @IBOutlet weak var searchBar: UISearchBar!
    var searchActive = false
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = (searchBar.text != "")
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        self.view.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.view.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedEquipment = equipment.filter({ e in
            return e.name.lowercased().contains(searchText.lowercased())  || searchText.isEmpty
        })
        if searchText.isEmpty {//searchString ∆-> nothing; user ended search
            searchActive = false
            self.view.endEditing(true)
        } else {
            searchActive = true
        }
        collectionView.reloadData()
    }
}
