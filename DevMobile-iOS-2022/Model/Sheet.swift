//
//  Track.swift
//  Test_Cours_listUI
//
//  Created by m1 on 08/02/2022.
//

import Foundation

struct SheetDTO: Decodable{
   
   var idFiche: Int
   var nomRecette: String
    var nomAuteur: String
    var Nbre_couverts: Int
    var categorieRecette: String
}

class Sheet: ObservableObject {
    public var idFiche: Int
    @Published var nomRecette : String
    @Published var nomAuteur: String
    @Published var Nbre_couverts: Int
    @Published var categorieRecette: String
    
    init(nomRecette: String, idFiche: Int, nomAuteur: String, Nbre_couverts: Int, categorieRecette: String){
        self.nomRecette = nomRecette
        self.idFiche = idFiche
        self.nomAuteur = nomAuteur
        self.Nbre_couverts = Nbre_couverts
        self.categorieRecette = categorieRecette
        
    }
    
}
