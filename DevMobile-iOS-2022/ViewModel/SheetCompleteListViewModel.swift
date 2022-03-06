//
//  SheetCompleteListViewModel.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 22/02/2022.


import SwiftUI

class SheetCompleteListViewModel: ObservableObject, SheetCompleteViewModelDelegate {
  
    var data: [SheetComplete]
    var datavm: [SheetCompleteViewModel]
    @Published var fetching : Bool = false
    
    func sheetCompleteViewModelChanged() {
        objectWillChange.send()
    }
 
       @Published var sheetListState : SheetCompleteListState = .ready{
           didSet{
               print("state: \(self.sheetListState)")
               switch self.sheetListState { // state has changed
               case .loaded(let data):    // new data has been loaded, to change all games of list
                   //let sortedData = data.sorted(by: { $0. < $1.name })
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
        SheetCompleteListViewIntent(list : self ).load(url: "https://awi-back-2021.herokuapp.com/api/sheet/join")
        self.fetching = true
        let surl = "https://awi-back-2021.herokuapp.com/api/sheet/join"
            guard let url = URL(string: surl) else { print("rien"); return }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data,response,error in
                guard let data = data else{return}
                do{
                    let dataDTO : [SheetCompleteDTO] = try JSONDecoder().decode([SheetCompleteDTO].self, from: data)
                    //SheetCompleteListViewIntent(list : self ).httpJsonLoaded(result: dataDTO)
                    for tdata in dataDTO{
                        let sheet = SheetComplete(nomRecette: tdata.nomRecette, idFiche: tdata.idFiche, nomAuteur: tdata.nomAuteur, Nbre_couverts: tdata.Nbre_couverts, categorieRecette: tdata.categorieRecette, nomProgression: tdata.nomProgression ?? "" )
                        //let hasSheet = self.data.contains(where: { $0.idFiche == sheet.idFiche })
                        //if hasSheet == false {
                            self.data.append(sheet)
                        //}
                        //self.data.append(sheet)
                        let vm = SheetCompleteViewModel(sheet: sheet)
                        vm.delegate = self
                            self.datavm.append(vm)
                        //self.vms.append(vm)
                    }
                    DispatchQueue.main.async {
                        SheetCompleteListViewIntent(list : self ).loaded(sheets: self.data)
                        self.fetching = false
                        //print(self.data)
                    }
                    
                }catch{
                    DispatchQueue.main.async { 
                        self.fetching = false
                        self.sheetListState = .loadingError("\(error)")
                        print("error")
                    }
                    print("Error: \(error)")
                }

            }.resume()
       
    }
    
    func fetchData(){
        self.datavm = []
        self.data = []
        fetching = true
        //SheetCompleteListViewIntent(list : self ).loadEditeurs(url: "https://awi-back-2021.herokuapp.com/api/sheet/join")
        let surl = "https://awi-back-2021.herokuapp.com/api/sheet/join"
            guard let url = URL(string: surl) else { print("rien"); return }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data,response,error in
                guard let data = data else{return}
                do{
                    let dataDTO : [SheetCompleteDTO] = try JSONDecoder().decode([SheetCompleteDTO].self, from: data)
                    //print(re)
                    //SheetCompleteListViewIntent(list : self ).httpJsonLoaded(result: dataDTO)
                    for tdata in dataDTO{
                        let sheet = SheetComplete(nomRecette: tdata.nomRecette, idFiche: tdata.idFiche, nomAuteur: tdata.nomAuteur, Nbre_couverts: tdata.Nbre_couverts, categorieRecette: tdata.categorieRecette, nomProgression: tdata.nomProgression ?? "" )
                        //let hasSheet = self.data.contains(where: { $0.idFiche == sheet.idFiche })
                        //if hasSheet == false {
                            self.data.append(sheet)
                        //}
                        //self.data.append(sheet)
                        let vm = SheetCompleteViewModel(sheet: sheet)
                        vm.delegate = self
                        //let hasSheetvm = self.vms.contains(where: { $0.sheet.idFiche == vm.sheet.idFiche })
                        //if hasSheetvm == false {
                            self.datavm.append(vm)
                        //}
                        //self.vms.append(vm)
                    }
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        SheetCompleteListViewIntent(list : self ).loaded(sheets: self.data)
                        self.fetching = false
                        //print(self.data)
                    }
                    
                }catch{
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        self.fetching = false
                        self.sheetListState = .loadingError("\(error)")
                        print("error")
                    }
                    print("Error: \(error)")
                }

            }.resume()
       
    }
}
