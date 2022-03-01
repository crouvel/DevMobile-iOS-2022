//
//  Progression.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 28/02/2022.
//

import Foundation


class ProgressionToCreate : ObservableObject {
    var referenceProgression: String
    
    init(referenceProgression: String){
        self.referenceProgression = referenceProgression
    }
}

class ProgressionDTO : Decodable {
    var refProgression: String
    var idProgression: Int
    
    init(reference: String, id: Int){
        self.refProgression = reference
        self.idProgression = id
    }
}

class Progression : ObservableObject{
    var referenceProgression: String
    var idProgression: Int
    
    init(reference: String, id: Int){
        self.referenceProgression = reference
        self.idProgression = id
    }
}
