//
//  SheetDAO.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 23/02/2022.
//

import Foundation

class SheetDAO {
    static func CreateSheet(nomRecette: String, nomAuteur: String, nombreCouverts: Int, categorieRecette: String, vm: SheetCompleteViewModel){
        SheetCompleteIntent( vm: vm ).creating()
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
                      SheetCompleteIntent( vm: vm ).creatingError(error: error!)
                      return
                  }
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            if response.statusCode == 200  {
                SheetCompleteIntent( vm: vm ).sheetCreated()
                print("fiche supprimée !")
            }
        }
        task.resume()
    }
    
    static func deleteSheet(idFiche: Int, vm: SheetCompleteViewModel){
        SheetCompleteIntent( vm: vm ).deleting(s: "https://awi-back-2021.herokuapp.com/api/sheet/delete/\(idFiche)" )
        guard let url = URL(string: "https://awi-back-2021.herokuapp.com/api/sheet/delete/\(idFiche)") else {
            print("Error: cannot create URL")
            return
        }
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling DELETE")
                SheetCompleteIntent( vm: vm ).deletingError(error: error!)
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            if response.statusCode == 200  {
                SheetCompleteIntent( vm: vm ).sheetDeleted()
                print("fiche supprimée !")
            }
        }.resume()
    }
    
    static func fetchSheet(list : SheetCompleteListViewModel){
        list.datavm = []
        list.data = []
        SheetCompleteListViewIntent(list : list).load(url: "https://awi-back-2021.herokuapp.com/api/sheet/join")
        let surl = "https://awi-back-2021.herokuapp.com/api/sheet/join"
        guard let url = URL(string: surl) else { print("rien"); return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data,response,error in
            guard let data = data else{return}
            do{
                let dataDTO : [SheetCompleteDTO] = try JSONDecoder().decode([SheetCompleteDTO].self, from: data)
                SheetCompleteListViewIntent(list : list ).httpJsonLoaded(result: dataDTO)
                for tdata in dataDTO{
                    let sheet = SheetComplete(nomRecette: tdata.nomRecette, idFiche: tdata.idFiche, nomAuteur: tdata.nomAuteur, Nbre_couverts: tdata.Nbre_couverts, categorieRecette: tdata.categorieRecette, nomProgression: tdata.nomProgression ?? "" )
                    list.data.append(sheet)
                    let vm = SheetCompleteViewModel(sheet: sheet)
                    vm.delegate = list
                    list.datavm.append(vm)
                }
                DispatchQueue.main.async {
                    SheetCompleteListViewIntent(list : list).loaded(sheets: list.data)
                    print("reload")
                    //print(self.data)
                }
            }catch{
                DispatchQueue.main.async {
                    list.sheetListState = .loadingError("\(error)")
                    print("error")
                }
                print("Error: \(error)")
            }
        }.resume()
    }
    
    static func fetchSheetIncomplete(list : SheetIncompleteListViewModel){
        list.datavm = []
        list.data = []
        //SheetCompleteListViewIntent(list : list).loadEditeurs(url: "https://awi-back-2021.herokuapp.com/api/sheet/incomplete")
        let surl = "https://awi-back-2021.herokuapp.com/api/sheet/incomplete"
        guard let url = URL(string: surl) else { print("rien"); return }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data,response,error in
            guard let data = data else{return}
            do{
                let dataDTO : [SheetCompleteDTO] = try JSONDecoder().decode([SheetCompleteDTO].self, from: data)
                //SheetCompleteListViewIntent(list : list ).httpJsonLoaded(result: dataDTO)
                for tdata in dataDTO{
                    let sheet = SheetComplete(nomRecette: tdata.nomRecette, idFiche: tdata.idFiche, nomAuteur: tdata.nomAuteur, Nbre_couverts: tdata.Nbre_couverts, categorieRecette: tdata.categorieRecette, nomProgression: tdata.nomProgression ?? "" )
                    list.data.append(sheet)
                    let vm = SheetCompleteViewModel(sheet: sheet)
                    //vm.delegate = list
                    list.datavm.append(vm)
                }
                DispatchQueue.main.async {
                    //SheetCompleteListViewIntent(list : list).loaded(sheets: list.data)
                    print("reload")
                    //print(self.data)
                }
            }catch{
                DispatchQueue.main.async {
                    //list.sheetListState = .loadingError("\(error)")
                    print("error")
                }
                print("Error: \(error)")
            }
        }.resume()
    }
    
    static func updateRecette(nom: String, idFiche: Int){
        let url = URL(string: "https://awi-back-2021.herokuapp.com/api/sheet/updateNomRecette")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        let parameters: [String: Any] = [
            "nomRecette" : nom,
            "id" : idFiche
        ]
        request.httpBody = parameters.percentEncoded()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {                                              // check for fundamental networking error
                      print("error", error ?? "Unknown error")
                      //IngredientIntent( vm: vm ).creatingError(error: error!)
                      return
                  }
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            if response.statusCode == 200  {
                //IngredientIntent( vm: vm ).ingredientCreated()
                print("modif !")
            }
        }
        task.resume()
    }

    static func updateCouvert(couvert: Int, idFiche: Int, oldcouvert: Int, nomProgression: String){
        let url = URL(string: "https://awi-back-2021.herokuapp.com/api/sheet/updateNbcouverts")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        let parameters: [String: Any] = [
            "nbCouvert" : couvert,
            "id" : idFiche
        ]
        request.httpBody = parameters.percentEncoded()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {                                              // check for fundamental networking error
                      print("error", error ?? "Unknown error")
                      //IngredientIntent( vm: vm ).creatingError(error: error!)
                      return
                  }
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            if response.statusCode == 200  {
                SheetDAO.updateAllQte(progression: nomProgression, couvert: couvert, oldcouvert: oldcouvert)
                //print("modif !")
            }
        }
        task.resume()
    }

    static func updateAllQte(progression:String, couvert : Int, oldcouvert: Int ){
        let url = URL(string: "https://awi-back-2021.herokuapp.com/api/sheet/updateAllQuantite")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        let parameters: [String: Any] = [
            "nbCouvert" : couvert,
            "nbCouvertModified" : oldcouvert,
            "nomProgression" : progression
        ]
        request.httpBody = parameters.percentEncoded()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {                                              // check for fundamental networking error
                      print("error", error ?? "Unknown error")
                      //IngredientIntent( vm: vm ).creatingError(error: error!)
                      return
                  }
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
            if response.statusCode == 200  {
                
                print("modif !")
            }
        }
        task.resume()
    }
}
