//
//  StepProgressionListViewModel.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 22/02/2022.
//

import SwiftUI

class StepProgressionListViewModel: ObservableObject/*, SheetCompleteViewModelDelegate*/ {
  

    var data: [StepProgression]
    var vms: [StepProgressionViewModel]
    var referenceProgression: String
    
    /*func sheetCompleteViewModelChanged() {
        objectWillChange.send()
    }*/
 
       @Published var stepListState : StepProgressionListState = .ready{
           didSet{
               print("state: \(self.stepListState)")
               switch self.stepListState { // state has changed
               case .loaded(let data):    // new data has been loaded, to change all games of list
                   //let sortedData = data.sorted(by: { $0. < $1.name })
                   print(data)
                   if data.count == 0 {
                       self.stepListState = .loadingError("la")
                   }
               default:                   // nothing to do for ViewModel, perhaps for the view
                   return
               }
           }
       }
    
    init(referenceProgression: String){
        self.vms = []
        self.data = []
        self.referenceProgression = referenceProgression
        self.stepListState = .loading("https://awi-back-2021.herokuapp.com/api/sheet/\(referenceProgression)/steps")
        let surl = "https://awi-back-2021.herokuapp.com/api/sheet/\(String(referenceProgression.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""))/steps"
        print(surl)
        guard let url = URL(string: surl) else { print("rien"); return }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data,response,error in
                guard let data = data else{return}
                do{
                    let dataDTO : [StepProgressionDTO] = try JSONDecoder().decode([StepProgressionDTO].self, from: data)
                    //print(re)
                    for tdata in dataDTO{
                        let id = tdata.id2 ?? tdata.id1
                        let step = StepProgression(id1: tdata.id1, titre1: tdata.titre1, ordre1: tdata.ordre1, temps1: tdata.temps1, description1: tdata.description1 ,id2: tdata.id2, titre2: tdata.titre2, ordre2: tdata.ordre2, temps2: tdata.temps2, description2: tdata.description2, id: id)
                        self.data.append(step)
                        let vm = StepProgressionViewModel(step: step)
                        //vm.delegate = self
                        self.vms.append(vm)
                    }
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        self.stepListState = .loaded(self.data)
                        print(self.data)
                    }
                    
                }catch{
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        self.stepListState = .loadingError("\(error)")
                        print("error")
                    }
                    print("Error: \(error)")
                }
            }.resume()
       
    }
}
