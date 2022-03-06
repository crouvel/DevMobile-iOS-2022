//
//  IngredientsProgressionListViewModel.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 25/02/2022.
//


import SwiftUI
import Foundation

class IngredientsProgressionListViewModel: ObservableObject/*, SheetCompleteViewModelDelegate*/ {
  

    var data: [IngredientProgression]
    var vms: [IngredientProgressionViewModel]
    var idFiche: Int
    
    /*func sheetCompleteViewModelChanged() {
        objectWillChange.send()
    }*/
 
       @Published var ingredientListState : IngredientProgressionListState = .ready{
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
    
    init(idFiche: Int){
        self.vms = []
        self.data = []
        self.idFiche = idFiche
        self.ingredientListState = .loading("https://awi-back-2021.herokuapp.com/api/sheet/\(idFiche)/ingredients")
        let surl = "https://awi-back-2021.herokuapp.com/api/sheet/\(idFiche)/ingredients"
        print(surl)
        guard let url = URL(string: surl) else { print("rien"); return }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data,response,error in
                guard let data = data else{return}
                do{
                    let dataDTO : [IngredientProgressionDTO] = try JSONDecoder().decode([IngredientProgressionDTO].self, from: data)
                    //print(re)
                    self.ingredientListState = .loaded(dataDTO)
                    for tdata in dataDTO{
                        let ingredient = IngredientProgression(codes: tdata.codes, ingredients: tdata.ingredients, unites: tdata.unites, quantites: tdata.quantites, prix: tdata.prix, prix_total: tdata.prix_total, nomListeIngredients: tdata.nomListeIngredients)
                        self.data.append(ingredient)
                        let vm = IngredientProgressionViewModel(ingredient: ingredient)
                        //vm.delegate = self
                        self.vms.append(vm)
                    }
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        self.ingredientListState = .ready
                        //print(self.data)
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
    
    func fetchData(idFiche: Int){
        self.vms = []
        self.data = []
        self.idFiche = idFiche
        self.ingredientListState = .loading("https://awi-back-2021.herokuapp.com/api/sheet/\(idFiche)/ingredients")
        let surl = "https://awi-back-2021.herokuapp.com/api/sheet/\(idFiche)/ingredients"
        print(surl)
        guard let url = URL(string: surl) else { print("rien"); return }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data,response,error in
                guard let data = data else{return}
                do{
                    let dataDTO : [IngredientProgressionDTO] = try JSONDecoder().decode([IngredientProgressionDTO].self, from: data)
                    //print(re)
                    self.ingredientListState = .loaded(dataDTO)
                    for tdata in dataDTO{
                        let ingredient = IngredientProgression(codes: tdata.codes, ingredients: tdata.ingredients, unites: tdata.unites, quantites: tdata.quantites, prix: tdata.prix, prix_total: tdata.prix_total, nomListeIngredients: tdata.nomListeIngredients)
                        self.data.append(ingredient)
                        let vm = IngredientProgressionViewModel(ingredient: ingredient)
                        //vm.delegate = self
                        self.vms.append(vm)
                    }
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        self.ingredientListState = .ready
                        //print(self.data)
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
