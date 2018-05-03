//
//  EquipmentCollectionViewController.swift
//  weg-ios
//
//  Created by Taylor, James on 4/29/18.
//  Copyright © 2018 James JM Taylor. All rights reserved.
//

import UIKit

class EquipmentCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate{

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var equipment = [Equipment]()
    var searchedEquipment = [Equipment]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        searchBar.delegate = self
        getEquipment()
    }
    override func viewDidLayoutSubviews() {
        setupCollectionViewLayout()
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
                    self.equipment = e
                    self.collectionView.reloadData()
                }
            }
        }
        guard let unwrappedEquipment = storedEquipment else {
            spinner = self.view.getAndStartActivityIndicator();return
        }
        equipment = unwrappedEquipment
        collectionView.reloadData()
    }

    // MARK: - Navigation
    private let equipmentSegue = "showEquipmentSegue"
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == equipmentSegue {
            guard let dest = segue.destination as? EquipmentViewController else {return}
            dest.equipment = sender as? Equipment
        }
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
        let e = (searchActive) ? searchedEquipment[indexPath.row] : equipment[indexPath.row]
        performSegue(withIdentifier: equipmentSegue, sender: e)
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
