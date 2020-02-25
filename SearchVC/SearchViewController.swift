//
//  SearchViewController.swift
//  Hoodable
//
//  Created by Rustam Atabaev on 05/02/20.
//  Copyright © 2020 Rustam Atabaev. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
  
    

    var  spotListArray = Array<Any>()
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    var searchListArray = Array<Any>()
    var spotArray = Array<Any>();
    var search = Bool()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        search = false
        searchListArray.removeAll();
        
        for spot in spotListArray {
            let spotArray = spot as! NSDictionary;
            if let keyexist = spotArray["business_type_id"]{
                    searchListArray.append(spot);
            }            
        }
        spotArray = searchListArray
        // Do any additional setup after loading the view.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    // MARK: CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("searchListArray Count()",searchListArray.count)
        return searchListArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "SearchCollectionViewCell"
        collectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: identifier)
        let cell: SearchCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? SearchCollectionViewCell
        //print("searchListArray",self.searchListArray)
        //print("indexPath:",indexPath.row);
        
         if let ttt = ((self.searchListArray[indexPath.row] as! NSDictionary)["image_url"] as? String)
        {
            cell.proImg.sd_setImage(with: URL(string: (self.searchListArray[indexPath.row] as! NSDictionary)["image_url"] as! String), placeholderImage: UIImage(named:"bar.jpeg"), options: [], completed: nil)
        }
        
        cell.nameLbl.text = ((self.searchListArray[indexPath.row] as! NSDictionary)["spot_name"] as! String).capitalized
        cell.descLbl.text = ((self.searchListArray[indexPath.row] as! NSDictionary)["spot_description"] as! String)
        cell.ratingLbl.text = "Rating: 4.2"
        
        cell.phoneBtn.tag = indexPath.row
 
        cell.phoneBtn.addTarget(self, action: #selector(phoneAction), for: .touchUpInside)
 

        return cell
        
    }
    
    @objc  func phoneAction(sender: UIButton) {
        

        if let url = NSURL(string: "tel://\(((self.searchListArray[sender.tag] as! NSDictionary)["spot_phone"] as! String))"), UIApplication.shared.canOpenURL(url as URL) {
            UIApplication.shared.openURL(url as URL)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        // let width = (UIScreen.main.bounds.width/2)-15
        
        return CGSize(width:self.view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let  spotDetailViewController = storyboard.instantiateViewController(withIdentifier: "SpotDetailViewController") as! SpotDetailViewController
        spotDetailViewController.spotDetailDict = (searchListArray[indexPath.row] as! NSDictionary)
        navigationController?.pushViewController(spotDetailViewController, animated: true)
        
        
    }
    
}



extension SearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "", searchText.count > 0 {
            
            print("searchText:",searchText)
            print("searchListArray",spotArray)
            
            searchListArray = spotArray.filter {
                search = true
                return (($0 as! NSDictionary)["spot_name"] as! String).range(of: searchText, options: .caseInsensitive) != nil
            }
            
            print("filteredSearch:",searchListArray)
        }
        else{
            search = false
            searchListArray = spotArray
        }
        searchCollectionView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchBar.endEditing(true)
    }
}
