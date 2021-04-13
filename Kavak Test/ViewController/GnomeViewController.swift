//
//  GnomeViewController.swift
//  Kavak Test
//
//  Created by Memo on 4/13/21.
//

import UIKit

class GnomeViewController: MVVMCollectionViewController<GnomesViewModel> {
    
    private let activityIndicator = UIActivityIndicatorView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchGnomes()
    }
    
    @objc
    func hideKeyboard() {
        view.endEditing(true)
    }
}

extension GnomeViewController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: GnomeCollectionViewCell.self), for: indexPath as IndexPath) as! GnomeCollectionViewCell
        cell.gnome = viewModel.gnome(at: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: 150)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showGnomeDetailViewController(gnome: viewModel.gnome(at: indexPath.row))
    }
}

extension GnomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel.filterContentForSearchText(text)
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.didCancelFiltering()
    }
}


//MARK: - Private Methods
private extension GnomeViewController {
    
    func configureUI() {
        
        navigationItem.title = "Gnomes"
        navigationItem.searchController = searchController
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Gnomes"
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        
        collectionView?.backgroundColor = UIColor.tertiarySystemBackground
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        collectionView.register(GnomeCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: GnomeCollectionViewCell.self))
        collectionView.backgroundView = activityIndicator
        
        activityIndicator.hidesWhenStopped = true
    }
    
    func errorAlert() {
        
        let retryAction = UIAlertAction(title: "Reintentar", style: .default) { _ in
            self.fetchGnomes()
        }
        
        let closeAction = UIAlertAction(title: "Cerrar", style: .cancel, handler: nil)
        
        Utils.showAlert(in: self,
                        title: "Kavak Test",
                        message: "There was an error trying to process the request, do you want to try again?",
                        alertActions: [closeAction, retryAction])
    }
    
    func fetchGnomes() {
        
        activityIndicator.startAnimating()
        viewModel.setup { [unowned self] success in
            
            self.activityIndicator.stopAnimating()
            
            guard success else {
                self.errorAlert()
                return
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
