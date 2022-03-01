//
//  Track.swift
//  Test_Cours_listUI
//
//  Created by m1 on 08/02/2022.
//

import Foundation

struct IngredientDTO: Decodable{
    var idIngredient: Int
    var libelle: String
    var libelleCategorie: String
}

/*protocol TrackObserver {
 func changed(trackName: String)
 func changed(collectionName: String)
 func changed(artistName: String)
 }*/

/*enum TrackPropertyChange {
 case TRACKNAME
 case ARTISTNAME
 case COLLECTIONNAME
 }*/

class Ingredient: ObservableObject {
    /*private var observers: [TrackObserver] = []*/
    @Published var idIngredient: Int
    @Published var libelle : String
    @Published var nomCategorie: String
    /*@Published var trackName: String {
     didSet {
     notifyObservers(t: .TRACKNAME)
     }
     }
     @Published var artistName: String {
     didSet {
     if(artistName.count < 3){
     artistName = oldValue
     }
     notifyObservers(t: .ARTISTNAME)
     }
     }
     @Published var collectionName: String {
     didSet {
     notifyObservers(t: .COLLECTIONNAME)
     }
     }
     @Published var releaseDate: String
     private enum CodingKeys: String, CodingKey {
     case trackId = "trackId"
     case trackName = "trackName"
     case artistName = "artistName"
     case collectionName = "collectionName"
     case releaseDate = "releaseDate"
     }
     */
    
    init(libelle: String, idIngredient: Int, nomCategorie: String){
        self.libelle = libelle
        self.idIngredient = idIngredient
        self.nomCategorie = nomCategorie
        
    }
    
    /*func addObserver(obs: TrackObserver){
     observers.append(obs)
     }*/
    
    /*func notifyObservers(t: TrackPropertyChange){
     for observer in observers {
     switch t {
     case .ARTISTNAME:
     observer.changed(artistName: artistName)
     case .COLLECTIONNAME:
     observer.changed(collectionName: collectionName)
     case .TRACKNAME:
     observer.changed(trackName: trackName)
     }
     }
     }*/
}
