//
//  GnomeViewModel.swift
//  Kavak Test
//
//  Created by Memo on 4/13/21.
//

import Foundation

class GnomesViewModel {
    
    private var gnomes: [Gnome]
    private var filteredGnomes: [Gnome]

    init() {
        gnomes = []
        filteredGnomes = []
    }
    
    func setup(_ completion: @escaping (Bool) -> Void) {
        RestAPI.fetchGnomes { [unowned self] result in
            
            switch result {
            case .success(let response):

                self.gnomes = response

                completion(true)

            case .failure:
                completion(false)
            }
        }
    }
    
    func count() -> Int {
        filteredGnomes.isEmpty ? gnomes.count : filteredGnomes.count
    }
    
    func gnome(at index: Int) -> Gnome {
        filteredGnomes.isEmpty ? gnomes[index] : filteredGnomes[index]
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredGnomes = gnomes.filter { (gnome: Gnome) -> Bool in
            return gnome.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    func didCancelFiltering() {
        filteredGnomes.removeAll()
    }
}
