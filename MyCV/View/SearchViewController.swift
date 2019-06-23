//
//  SearchViewController.swift
//  MyCV
//
//  Created by Leming Deng on 2019-06-22.
//  Copyright © 2019 Leming Deng. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.allowsMultipleSelection = true
            collectionView.register(UINib(nibName: "SearchCell", bundle: nil) , forCellWithReuseIdentifier: "Cell")
            if let flowlayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowlayout.estimatedItemSize = CGSize(width: 50, height: 30)
            }
        }
    }
    var viewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.performBatchUpdates(nil) { (_) in
            self.viewModel.candidates.enumerated().forEach {
                let indexPath = IndexPath(row: $0.offset, section: 0)
                if self.viewModel.filters.contains($0.element) {
                    self.collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
                } else {
                    self.collectionView.deselectItem(at: indexPath, animated: false)
                }
            }
            self.collectionView.frame.size = self.collectionView.contentSize
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.candidates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SearchCell
        let key = viewModel.candidates[indexPath.row]
        cell.title.text = key
        cell.isSelected = viewModel.filters.contains(key)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.filters.insert(viewModel.candidates[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        viewModel.filters.remove(viewModel.candidates[indexPath.row])
    }
}
