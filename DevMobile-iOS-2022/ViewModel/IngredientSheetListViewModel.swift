//
//  IngredientSheetListViewModel.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 04/03/2022.
//

import Foundation

class IngredientSheetListViewModel: ObservableObject {
    var data: [IngredientSheet]
    var vms: [IngredientSheetViewModel]
    
    /// State of new data loading
    /*@Published var ingredientListState : IngredientsListState = .ready{
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
     }*/
    
    init(){
        self.vms = []
        self.data = []
        //self.ingredientListState = .loading("https://awi-back-2021.herokuapp.com/api/ingredients/sheet")
        let surl = "https://awi-back-2021.herokuapp.com/api/ingredients/sheet"
        guard let url = URL(string: surl) else { print("rien"); return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data,response,error in
            guard let data = data else{return}
            do{
                let dataDTO : [IngredientSheetDTO] = try JSONDecoder().decode([IngredientSheetDTO].self, from: data)
                //print(re)
                for tdata in dataDTO{
                    let ingredient = IngredientSheet(libelle: tdata.libelle, idIngredient: tdata.idIngredient)
                    self.data.append(ingredient)
                    let vm = IngredientSheetViewModel(ingredient: ingredient)
                    self.vms.append(vm)
                }
                DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                    //self.ingredientListState = .loaded(self.data)
                    print(self.data)
                }
            }catch{
                DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                    //self.ingredientListState = .loadingError("\(error)")
                    print("\(error)")
                }
                print("Error: \(error)")
            }
        }.resume()
    }
}
