//
//  IngredientDAO.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 04/03/2022.
//

import Foundation

class IngredientDAO {
    static func deleteIngredient(idIngredient: Int, vm: IngredientViewModel){
        //SheetCompleteIntent( vm: vm ).deleting(s: "https://awi-back-2021.herokuapp.com/api/ingredients/delete/\(idIngredient)" )
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
                //SheetCompleteIntent( vm: vm ).deletingError(error: error!)
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
                //SheetCompleteIntent( vm: vm ).sheetDeleted()
                print("fiche supprimée !")
            }
        }.resume()
    }
}
