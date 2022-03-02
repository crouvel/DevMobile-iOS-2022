//
//  IngredientListDAO.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 01/03/2022.
//

import Foundation

class IngredientsListStepDAO {
    static func CreateIngredientList(nomListe: String, nomProgression: String, vm: SheetCompleteViewModel){
        let url = URL(string: "https://awi-back-2021.herokuapp.com/api/ingredientsList/create")!
        //vm.creationStateIngredientList = .creating
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "nomListe": nomListe,
            "referenceProgression": nomProgression
        ]
        request.httpBody = parameters.percentEncoded()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }
            vm.creationStateIngredientList = .created

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                vm.creationStateIngredientList = .creatingError("\(response)")
                return
            }
            if response.statusCode == 200 {
                
            }
           

            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    static func AddIngredientList(nomListe: String, libelleIngredient: String, quantite: Double, nomProgression: String, vm: SheetCompleteViewModel){
        //var idListe : Int
        let surl = "https://awi-back-2021.herokuapp.com/api/ingredientsList/last/\(String(nomListe.addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""))"
        print(surl)
        guard let url1 = URL(string: surl) else { print("rien"); return }
            let request1 = URLRequest(url: url1)
            URLSession.shared.dataTask(with: request1) { data,response,error in
                guard let data = data else{return}
                do{
                    let tdata : [LastIngredientListDTO] = try JSONDecoder().decode([LastIngredientListDTO].self, from: data)
                    //print(re)
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        print(tdata)
                        IngredientsListStepDAO.AddIngredientListFinal(libelleIngredient: libelleIngredient, quantite: quantite, idListeIngredient: tdata[0].idLastCreatedList, nomProgression: nomProgression, vm: vm)
                    }
                }
                catch{
                    DispatchQueue.main.async { // met dans la file d'attente du thread principal l'action qui suit
                        print("error")
                    }
                    print("Error: \(error)")
                }
            }.resume()
    }
    
    static func AddIngredientListFinal(libelleIngredient: String, quantite: Double, idListeIngredient: Int, nomProgression: String, vm: SheetCompleteViewModel){
        let url = URL(string: "https://awi-back-2021.herokuapp.com/api/ingredients/addToListStep")!
        vm.addStateIngredientList = .adding
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "libelleIngredient": libelleIngredient ,
            "quantite": quantite,
            "lastIngredientsListStep": idListeIngredient,
            "referenceProgression": nomProgression
        ]
        request.httpBody = parameters.percentEncoded()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }
            vm.addStateIngredientList = .added
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                //vm.creationStateIngredientList = .creatingError("\(response)")
                vm.addStateIngredientList = .addingError("\(error)")
                return
            }
            if response.statusCode == 200 {
                //vm.creationStateIngredientList = .created
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }

        task.resume()
    }
    
}
