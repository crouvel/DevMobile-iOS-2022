//
//  Tracks.swift
//  Test_Cours_listUI
//
//  Created by m1 on 16/02/2022.
//

import SwiftUI

class SheetListViewModel: ObservableObject, SheetViewModelDelegate {
  

    var data: [Sheet]
    var vms: [SheetViewModel]
    
    func sheetViewModelChanged() {
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
        self.sheetListState = .loading("https://awi-back-2021.herokuapp.com/api/sheet")
        let surl = "https://awi-back-2021.herokuapp.com/api/sheet"
            guard let url = URL(string: surl) else { print("rien"); return }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data,response,error in
                guard let data = data else{return}

                do{
                    let dataDTO : [SheetDTO] = try JSONDecoder().decode([SheetDTO].self, from: data)
                    //print(re)
                    for tdata in dataDTO{
                        let sheet = Sheet(nomRecette: tdata.nomRecette, idFiche: tdata.idFiche, nomAuteur: tdata.nomAuteur, Nbre_couverts: tdata.Nbre_couverts, categorieRecette: tdata.categorieRecette )
                        self.data.append(sheet)
                        let vm = SheetViewModel(sheet: sheet)
                        vm.delegate = self
                        self.vms.append(vm)
                    }
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        self.sheetListState = .loaded(self.data)
                        print(self.data)
                    }
                    
                }catch{
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        self.sheetListState = .loadingError("\(error)")
                        print("error")
                    }
                    print("Error: \(error)")
                }

            }.resume()
       
    }
}
