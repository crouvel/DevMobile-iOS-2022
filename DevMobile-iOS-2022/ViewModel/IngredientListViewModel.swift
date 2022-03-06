//
//  Tracks.swift
//  Test_Cours_listUI
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI

class IngredientListViewModel: ObservableObject, IngredientViewModelDelegate {
    var data: [Ingredient]
    var datavm: [IngredientViewModel]
    
    func ingredientViewModelChanged() {
        objectWillChange.send()
    }
    
    @Published var ingredientListState : IngredientsListState = .ready{
        didSet{
            print("state: \(self.ingredientListState)")
            switch self.ingredientListState {
            case .loaded(let data):
                print(data)
                if data.count == 0 {
                    self.ingredientListState = .loadingError("la")
                }
            default:
                return
            }
        }
    }
    
    init(){
        self.datavm = []
        self.data = []
        self.ingredientListState = .loading("https://awi-back-2021.herokuapp.com/api/ingredients")
        let surl = "https://awi-back-2021.herokuapp.com/api/ingredients"
        guard let url = URL(string: surl) else { print("rien"); return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data,response,error in
            guard let data = data else{return}
            
            do{
                let dataDTO : [IngredientDTO] = try JSONDecoder().decode([IngredientDTO].self, from: data)
                //print(re)
                for tdata in dataDTO{
                    let ingredient = Ingredient(libelle: tdata.libelle, idIngredient: tdata.idIngredient, nomCategorie: tdata.libelleCategorie, quantite: tdata.quantiteStockee, prix: tdata.prixUnitaire, allergene: tdata.allergene, idCategorie: tdata.idCategorieIngredient, idCatAllergene: tdata.idCategorieAllergene ?? "", unite: tdata.unite)
                    self.data.append(ingredient)
                    let vm = IngredientViewModel(ingredient: ingredient)
                    vm.delegate = self
                    self.datavm.append(vm)
                }
                DispatchQueue.main.async {
                    self.ingredientListState = .loaded(self.data)
                    //print(self.data)
                }
                
            }catch{
                DispatchQueue.main.async { 
                    self.ingredientListState = .loadingError("\(error)")
                    print("\(error)")
                }
                print("Error: \(error)")
            }
            
        }.resume()
    }
    
    func fetchData(){
        self.datavm = []
        self.data = []
        self.ingredientListState = .loading("https://awi-back-2021.herokuapp.com/api/ingredients")
        let surl = "https://awi-back-2021.herokuapp.com/api/ingredients"
        guard let url = URL(string: surl) else { print("rien"); return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data,response,error in
            guard let data = data else{return}
            
            do{
                let dataDTO : [IngredientDTO] = try JSONDecoder().decode([IngredientDTO].self, from: data)
                //print(re)
                for tdata in dataDTO{
                    let ingredient = Ingredient(libelle: tdata.libelle, idIngredient: tdata.idIngredient, nomCategorie: tdata.libelleCategorie, quantite: tdata.quantiteStockee, prix: tdata.prixUnitaire, allergene: tdata.allergene, idCategorie: tdata.idCategorieIngredient, idCatAllergene: tdata.idCategorieAllergene ?? "", unite: tdata.unite)
                    self.data.append(ingredient)
                    let vm = IngredientViewModel(ingredient: ingredient)
                    vm.delegate = self
                    self.datavm.append(vm)
                }
                DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                    self.ingredientListState = .loaded(self.data)
                    //print(self.data)
                }
                
            }catch{
                DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                    self.ingredientListState = .loadingError("\(error)")
                    print("\(error)")
                }
                print("Error: \(error)")
            }
            
        }.resume()
    }
}
