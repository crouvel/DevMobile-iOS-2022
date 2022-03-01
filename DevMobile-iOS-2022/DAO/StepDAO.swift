//
//  StepDAO.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 28/02/2022.
//

import Foundation
class StepDAO {
    static func CreateStep(titre: String, ordre: Int, temps: Int, description: String, refprogression: String, desprogression: String){
        let url = URL(string: "https://awi-back-2021.herokuapp.com/api/step/create")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters : [String : Any]
        if desprogression == "" {
        parameters = [
            "titre": titre,
            "description": description,
            "temps": temps,
            "ordre": ordre,
            "referenceProgression": refprogression,
        ]}else {
            parameters = [
                "titre": titre,
                "description": description,
                "temps": temps,
                "ordre": ordre,
                "referenceProgression": refprogression,
                "descriptionProgression": desprogression,
            ]
        }
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

}
