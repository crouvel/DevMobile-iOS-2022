//
//  ProgressionListViewModel.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 28/02/2022.
//

import Foundation

enum ProgressionListState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded([Progression])
    case loadingError(String)
    //case newEditeurs([EditeurViewModel])

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .loading(let s)                      : return "loading"
        case .loaded(let editeurs)                  : return "loaded: \(editeurs.count) progressions"
        case .loadingError(let error)             : return "loadingError: Error loading -> \(error)"
        //case .newEditeurs(let editeurs)               : return "newJeu: reset game list with \(editeurs.count) editors"
        }
    }
    
}

class ProgressionListViewModel : ObservableObject/*, SheetCompleteViewModelDelegate */{
        var data: [Progression]
        var vms: [ProgressionViewModel]
        
        /*func sheetCompleteViewModelChanged() {
            objectWillChange.send()
        }*/
     
           @Published var progressionListState : ProgressionListState = .ready{
               didSet{
                   print("state: \(self.progressionListState)")
                   switch self.progressionListState { // state has changed
                   case .loaded(let data):    // new data has been loaded, to change all games of list
                       //let sortedData = data.sorted(by: { $0. < $1.name })
                       print(data)
                       if data.count == 0 {
                           self.progressionListState = .loadingError("la")
                       }
                   default:                   // nothing to do for ViewModel, perhaps for the view
                       return
                   }
               }
           }
        
        init(){
            self.vms = []
            self.data = []
            //SheetListViewIntent(list : self ).loadEditeurs(url: "https://awi-back-2021.herokuapp.com/api/sheet/incomplete")
            self.progressionListState = .loading("https://awi-back-2021.herokuapp.com/api/progression/progressionOrigin")
            let surl = "https://awi-back-2021.herokuapp.com/api/progression/progressionOrigin"
                guard let url = URL(string: surl) else { print("rien"); return }
                let request = URLRequest(url: url)
                URLSession.shared.dataTask(with: request) { data,response,error in
                    guard let data = data else{return}
                    do{
                        let dataDTO : [ProgressionDTO] = try JSONDecoder().decode([ProgressionDTO].self, from: data)
                        //SheetListViewIntent(list : self ).httpJsonLoaded(results: dataDTO)
                        //print(re)
                        for tdata in dataDTO{
                            //let nomProgression = ""
                            let progression = Progression(reference: tdata.refProgression, id: tdata.idProgression )
                            self.data.append(progression)
                            let vm = ProgressionViewModel(progression: progression)
                            //vm.delegate = self
                            self.vms.append(vm)
                        }
                        DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                            self.progressionListState = .loaded(self.data)
                            //SheetListViewIntent(list : self ).httpJsonLoaded(results: dataDTO)
                            //SheetListViewIntent(list : self ).loaded(sheets: self.data)
                            print(self.data)
                        }
                        
                    }catch{
                        DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                            //SheetListViewIntent(list : self ).httpJsonLoadedError(error: error)
                            self.progressionListState = .loadingError("\(error)")
                            print("error")
                        }
                        print("Error: \(error)")
                    }

                }.resume()
           
        }

}
