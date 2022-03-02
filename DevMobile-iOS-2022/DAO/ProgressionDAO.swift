//
//  ProgressionDAO.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 28/02/2022.
//

import Foundation

class ProgressionDAO {
    //@ObservedObject var vm: ProgressionViewModel = ProgressionViewModel(progression: )
    static func CreateProgression(nomProgression: String, nomRecette: String, vm: SheetCompleteViewModel){
        let url = URL(string: "https://awi-back-2021.herokuapp.com/api/progression/create")!
        vm.creationState = .creating
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "referenceProgression": nomProgression,
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
            if response.statusCode == 200 {
                ProgressionDAO.addProgressionSheet(nomProgression: nomProgression, nomRecette: nomRecette, vm: vm)
            }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }

        task.resume()
        
    }
    
    static func addProgressionSheet(nomProgression: String, nomRecette: String, vm: SheetCompleteViewModel){
        let url = URL(string: "https://awi-back-2021.herokuapp.com/api/progression/addSheet")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "nomRecette": nomRecette,
            "referenceProgression": nomProgression,
        ]
        request.httpBody = parameters.percentEncoded()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode
            else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                vm.creationState = .creatingError("\(response)")
                return
            }
            
             DispatchQueue.main.async {
            vm.creationState = .created
             }
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }

        task.resume()
    }

}
