//
//  Track.swift
//  Test_Cours_listUI
//
//  Created by m1 on 08/02/2022.
//

import Foundation
import CoreText

struct SheetCompleteDTO: Decodable{
   
   var idFiche: Int
   var nomRecette: String
    var nomAuteur: String
    var Nbre_couverts: Int
    var categorieRecette: String
    var nomProgression: String
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

class SheetComplete: ObservableObject {
    /*private var observers: [TrackObserver] = []*/
    public var idFiche: Int
    @Published var nomRecette : String
    @Published var nomAuteur: String
    @Published var Nbre_couverts: Int
    @Published var categorieRecette: String
    @Published var nomProgression: String
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
    
    init(nomRecette: String, idFiche: Int, nomAuteur: String, Nbre_couverts: Int, categorieRecette: String, nomProgression: String){
        self.nomRecette = nomRecette
        self.idFiche = idFiche
        self.nomAuteur = nomAuteur
        self.Nbre_couverts = Nbre_couverts
        self.categorieRecette = categorieRecette
        self.nomProgression = nomProgression
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
