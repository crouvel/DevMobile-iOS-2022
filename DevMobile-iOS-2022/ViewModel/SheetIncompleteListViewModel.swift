//
//  Tracks.swift
//  Test_Cours_listUI
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI

class SheetIncompleteListViewModel: ObservableObject/*, SheetCompleteViewModelDelegate*/ {
    var data: [SheetComplete]
    var datavm: [SheetCompleteViewModel]
    
    /*func sheetCompleteViewModelChanged() {
        objectWillChange.send()
    }*/
 
       @Published var sheetListState : SheetListState = .ready{
           didSet{
               print("state: \(self.sheetListState)")
               switch self.sheetListState {
               case .loaded(let data):
                   print(data)
                   if data.count == 0 {
                       self.sheetListState = .loadingError("la")
                   }
               default:
                   return
               }
           }
       }
    
    init(){
        self.datavm = []
        self.data = []
        SheetListViewIntent(list : self ).load(url: "https://awi-back-2021.herokuapp.com/api/sheet/incomplete")
        let surl = "https://awi-back-2021.herokuapp.com/api/sheet/incomplete"
            guard let url = URL(string: surl) else { print("rien"); return }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data,response,error in
                guard let data = data else{return}
                do{
                    let dataDTO : [SheetCompleteDTO] = try JSONDecoder().decode([SheetCompleteDTO].self, from: data)
                    SheetListViewIntent(list : self ).httpJsonLoaded(results: dataDTO)
                    
                    for tdata in dataDTO{
                        let nomProgression = ""
                        let sheet = SheetComplete(nomRecette: tdata.nomRecette, idFiche: tdata.idFiche, nomAuteur: tdata.nomAuteur, Nbre_couverts: tdata.Nbre_couverts, categorieRecette: tdata.categorieRecette, nomProgression: nomProgression )
                        self.data.append(sheet)
                        let vm = SheetCompleteViewModel(sheet: sheet)
                        //vm.delegate = self
                        self.datavm.append(vm)
                    }
                    DispatchQueue.main.async {
                        SheetListViewIntent(list : self ).loaded(sheets: self.data)
                    }
                    
                }catch{
                    DispatchQueue.main.async { 
                        SheetListViewIntent(list : self ).httpJsonLoadedError(error: error)
                        print("error")
                    }
                    print("Error: \(error)")
                }

            }.resume()
       
    }
}
