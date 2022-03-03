//
//  TotalCost.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 03/03/2022.
//

import Foundation

struct TotalCostDTO : Decodable {
    
    var prix_total: Float
    var qtetotale : Float
}

class TotalCost : ObservableObject {
    
    var prix_total: Float
    var qtetotale : Float
    
    init(prix_total: Float, qtetotale : Float){
        self.prix_total = prix_total
        self.qtetotale = qtetotale
    }
    
}
