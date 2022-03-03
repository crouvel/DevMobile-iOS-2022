//
//  TotalCostViewModel.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 03/03/2022.
//

import Foundation

class TotalCostViewModel : ObservableObject{
    private(set) var cost: TotalCost
    var prix_total : Float
    var qtetotale: Float
    
    
    init(cost: TotalCost){
        self.cost = cost
        self.prix_total = cost.prix_total
        self.qtetotale = cost.qtetotale
    }
}

class TotalCostsViewModel: ObservableObject {
  
    @Published var data: [TotalCost]
    @Published var vms: [TotalCostViewModel]
    var idFiche : Int
   
    init(idFiche: Int){
        self.vms = []
        self.data = []
        self.idFiche = idFiche
        //SheetCompleteListViewIntent(list : self ).loadEditeurs(url: "https://awi-back-2021.herokuapp.com/api/sheet/join")
        let surl = "https://awi-back-2021.herokuapp.com/api/sheet/\(idFiche)/total"
            guard let url = URL(string: surl) else { print("rien"); return }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data,response,error in
                guard let data = data else{return}
                do{
                    let dataDTO : [TotalCostDTO] = try JSONDecoder().decode([TotalCostDTO].self, from: data)
                    //print(re)
                    //SheetCompleteListViewIntent(list : self ).httpJsonLoaded(result: dataDTO)
                    for tdata in dataDTO{
                        let cost = TotalCost(prix_total: tdata.prix_total, qtetotale: tdata.qtetotale)
                            self.data.append(cost)
                        //self.data.append(sheet)
                        let vm = TotalCostViewModel(cost: cost)
                        self.vms.append(vm)
                        //}
                        //self.vms.append(vm)
                    }
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        //SheetCompleteListViewIntent(list : self ).loaded(sheets: self.data)
                        //self.fetching = false
                        //print(self.data)
                    }
                    
                }catch{
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        //self.fetching = false
                        //self.sheetListState = .loadingError("\(error)")
                        print("error")
                    }
                    print("Error: \(error)")
                }

            }.resume()
       
    }
}
