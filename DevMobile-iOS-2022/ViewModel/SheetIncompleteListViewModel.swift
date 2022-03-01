//
//  Tracks.swift
//  Test_Cours_listUI
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI

class SheetIncompleteListViewModel: ObservableObject, SheetCompleteViewModelDelegate {
    var data: [SheetComplete]
    var vms: [SheetCompleteViewModel]
    
    func sheetCompleteViewModelChanged() {
        objectWillChange.send()
    }
 
       @Published var sheetListState : SheetListState = .ready{
           didSet{
               print("state: \(self.sheetListState)")
               switch self.sheetListState { // state has changed
               case .loaded(let data):    // new data has been loaded, to change all games of list
                   //let sortedData = data.sorted(by: { $0. < $1.name })
                   print(data)
                   if data.count == 0 {
                       self.sheetListState = .loadingError("la")
                   }
               default:                   // nothing to do for ViewModel, perhaps for the view
                   return
               }
           }
       }
    
    init(){
        self.vms = []
        self.data = []
        SheetListViewIntent(list : self ).loadEditeurs(url: "https://awi-back-2021.herokuapp.com/api/sheet/incomplete")
        //self.sheetListState = .loading("https://awi-back-2021.herokuapp.com/api/sheet/incomplete")
        let surl = "https://awi-back-2021.herokuapp.com/api/sheet/incomplete"
            guard let url = URL(string: surl) else { print("rien"); return }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data,response,error in
                guard let data = data else{return}
                do{
                    let dataDTO : [SheetCompleteDTO] = try JSONDecoder().decode([SheetCompleteDTO].self, from: data)
                    SheetListViewIntent(list : self ).httpJsonLoaded(results: dataDTO)
                    //print(re)
                    for tdata in dataDTO{
                        let nomProgression = ""
                        let sheet = SheetComplete(nomRecette: tdata.nomRecette, idFiche: tdata.idFiche, nomAuteur: tdata.nomAuteur, Nbre_couverts: tdata.Nbre_couverts, categorieRecette: tdata.categorieRecette, nomProgression: nomProgression )
                        self.data.append(sheet)
                        let vm = SheetCompleteViewModel(sheet: sheet)
                        vm.delegate = self
                        self.vms.append(vm)
                    }
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        //self.sheetListState = .loaded(self.data)
                        //SheetListViewIntent(list : self ).httpJsonLoaded(results: dataDTO)
                        SheetListViewIntent(list : self ).loaded(sheets: self.data)
                        print(self.data)
                    }
                    
                }catch{
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        SheetListViewIntent(list : self ).httpJsonLoadedError(error: error)
                        print("error")
                    }
                    print("Error: \(error)")
                }

            }.resume()
       
    }
}
