//
//  IngredientDAO.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 04/03/2022.
//

import Foundation

class IngredientDAO {
    static func deleteIngredient(idIngredient: Int, vm: IngredientViewModel){
        IngredientIntent( vm: vm ).deleting(s: "https://awi-back-2021.herokuapp.com/api/ingredients/delete/\(idIngredient)" )
        guard let url = URL(string: "https://awi-back-2021.herokuapp.com/api/ingredients/delete/\(idIngredient)") else {
            print("Error: cannot create URL")
            return
        }
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling DELETE")
                IngredientIntent( vm: vm ).deletingError(error: error!)
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
                IngredientIntent( vm: vm ).ingredientDeleted()
                print("ingrédient supprimé !")
            }
        }.resume()
    }
    
    static func CreateIngredient(code: Int,libelle: String,quantiteStockee: Float,prixUnitaire: Float,allergene: String, idCategorieIngredient: Int,categorieAllergene: String?, unite: String, vm: IngredientViewModel){
        IngredientIntent( vm: vm ).creating()
        let url = URL(string: "https://awi-back-2021.herokuapp.com/api/ingredients/create")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any]
        if allergene == "Oui"{
            parameters = [
                "code" : code,
                "libelle" : libelle,
                "quantiteStockee" : quantiteStockee,
                "prixUnitaire": prixUnitaire,
                "allergene": allergene,
                "idCategorieIngredient": idCategorieIngredient,
                "categorieAllergene" : categorieAllergene,
                "unite": unite
            ]} else {
                parameters = [
                    "code" : code,
                    "libelle" : libelle,
                    "quantiteStockee" : quantiteStockee,
                    "prixUnitaire": prixUnitaire,
                    "allergene": allergene,
                    "idCategorieIngredient": idCategorieIngredient,
                    "unite": unite
                ]
            }
        request.httpBody = parameters.percentEncoded()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {                                              // check for fundamental networking error
                      print("error", error ?? "Unknown error")
                      IngredientIntent( vm: vm ).creatingError(error: error!)
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
                IngredientIntent( vm: vm ).ingredientCreated()
                print("fiche supprimée !")
            }
        }
        task.resume()
    }
}
