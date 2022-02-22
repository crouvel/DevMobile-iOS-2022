//
//  Tracks.swift
//  Test_Cours_listUI
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI

class IngredientListViewModel: ObservableObject, IngredientViewModelDelegate {
  

    var data: [Ingredient]
    var vms: [IngredientViewModel]
    
    func ingredientViewModelChanged() {
        objectWillChange.send()
    }
    /// State of new data loading
       @Published var ingredientListState : IngredientsListState = .ready{
           didSet{
               print("state: \(self.ingredientListState)")
               switch self.ingredientListState { // state has changed
               case .loaded(let data):    // new data has been loaded, to change all games of list
                   //let sortedData = data.sorted(by: { $0. < $1.name })
                   print(data)
                   if data.count == 0 {
                       self.ingredientListState = .loadingError("la")
                   }
               default:                   // nothing to do for ViewModel, perhaps for the view
                   return
               }
           }
       }
    
    init(){
        
        self.vms = []
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
                     
                        /*let id : Int = tdata.trackId ?? 0000
                        let name : String = tdata.trackName ?? "unspecified"
                        let artist : String = tdata.artistName ?? "unspecified"
                        let album : String = tdata.collectionName ?? "unspecified"
                        let date : String = tdata.releaseDate ?? "unspecified"*/
                        let ingredient = Ingredient(libelle: tdata.libelle, idIngredient: tdata.idIngredient, nomCategorie: tdata.libelleCategorie)
                        self.data.append(ingredient)
                        let vm = IngredientViewModel(ingredient: ingredient)
                        vm.delegate = self
                        self.vms.append(vm)
                    }
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        self.ingredientListState = .loaded(self.data)
                        print(self.data)
                    }
                    
                }catch{
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        self.ingredientListState = .loadingError("\(error)")
                        print("error")
                    }
                    print("Error: \(error)")
                }

            }.resume()
       
    }
}
