//
//  IngredientVenteListViewModel.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 06/03/2022.
//

import Foundation

import Foundation

class IngredientVenteListViewModel: ObservableObject {
    var data: [IngredientVente]
    var vms: [IngredientVenteViewModel]
    var idFiche : Int
    
    init(idFiche: Int){
        self.vms = []
        self.data = []
        self.idFiche = idFiche
        //self.ingredientListState = .loading("https://awi-back-2021.herokuapp.com/api/ingredients/sheet")
        let surl = "https://awi-back-2021.herokuapp.com/api/sheet/\(idFiche)/ingredientsByCategory"
        guard let url = URL(string: surl) else { print("rien"); return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data,response,error in
            guard let data = data else{return}
            do{
                let dataDTO : [IngredientVenteDTO] = try JSONDecoder().decode([IngredientVenteDTO].self, from: data)
                //print(re)
                for tdata in dataDTO{
                    let ingredient = IngredientVente(ingredients: tdata.ingredients, libelleCategorie: tdata.libelleCategorie )
                    self.data.append(ingredient)
                    let vm = IngredientVenteViewModel(ingredient: ingredient)
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
