//
//  SheetDAO.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 23/02/2022.
//

import Foundation

class SheetDAO {
    static func CreateSheet(nomRecette: String, nomAuteur: String, nombreCouverts: Int, categorieRecette: String){
        let url = URL(string: "https://awi-back-2021.herokuapp.com/api/sheet/create")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "nomRecette": nomRecette,
            "nomAuteur": nomAuteur,
            "nombreCouverts": nombreCouverts,
            "categorieRecette": categorieRecette,
        ]
        request.httpBody = parameters.percentEncoded()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }

        task.resume()
        
    }
    
    static func deleteSheet(idFiche: Int){
        let parameters: [String: Any] = [
            "id": idFiche
        ]
        guard let url = URL(string: "https://awi-back-2021.herokuapp.com/api/sheet/delete/\(idFiche)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject:parameters, options: []) else { return }
        request.httpBody = httpBody
    }
    
    static func fetchSheet(list : SheetCompleteListViewModel){
        list.vms = []
        list.data = []
        SheetCompleteListViewIntent(list : list).loadEditeurs(url: "https://awi-back-2021.herokuapp.com/api/sheet/join")
        let surl = "https://awi-back-2021.herokuapp.com/api/sheet/join"
            guard let url = URL(string: surl) else { print("rien"); return }
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data,response,error in
                guard let data = data else{return}
                do{
                    let dataDTO : [SheetCompleteDTO] = try JSONDecoder().decode([SheetCompleteDTO].self, from: data)
                    //print(re)
                    SheetCompleteListViewIntent(list : list ).httpJsonLoaded(result: dataDTO)
                    for tdata in dataDTO{
                        let sheet = SheetComplete(nomRecette: tdata.nomRecette, idFiche: tdata.idFiche, nomAuteur: tdata.nomAuteur, Nbre_couverts: tdata.Nbre_couverts, categorieRecette: tdata.categorieRecette, nomProgression: tdata.nomProgression )
                        list.data.append(sheet)
                        let vm = SheetCompleteViewModel(sheet: sheet)
                        vm.delegate = list
                        list.vms.append(vm)
                    }
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        SheetCompleteListViewIntent(list : list).loaded(sheets: list.data)
                        print("reload")
                        //print(self.data)
                    }
                    
                }catch{
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        list.sheetListState = .loadingError("\(error)")
                        print("error")
                    }
                    print("Error: \(error)")
                }

            }.resume()
       
    }
}
