//
//  IngredientsProgression.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 25/02/2022.
//

import Foundation

struct IngredientProgressionDTO: Decodable{
   /*static func tracksDTO2Track(data: [TrackDTO]) -> [Track]?{
      var tracks = [Track]()
      for tdata in data{
         /*guard (tdata.collectionId != nil) || (tdata.trackId != nil) else{
            return nil
         }
          let id : Int = tdata.trackId ?? 0000
          let name : String = tdata.trackName ?? "unspecified"
          let artist : String = tdata.artistName ?? "unspecified"
          let album : String = tdata.collectionName ?? "unspecified"
          let date : String = tdata.releaseDate ?? "unspecified"*/
          let track = Track(libelle: tdata.libelle, idIngredient: tdata.idIngredient, nomCategorie: tdata.libelleCategorie )
         tracks.append(track)
      }
      return tracks
   }*/
   var codes: String
   var ingredients: String
    var unites: String
    var quantites: String
    var prix: String
    var prix_total: String
    var nomListeIngredients: String
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

class IngredientProgression: ObservableObject {
    /*private var observers: [TrackObserver] = []*/
    var codes: String
    var ingredients: String
     var unites: String
     var quantites: String
     var prix: String
     var prix_total: String
     var nomListeIngredients: String
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

    init(codes: String, ingredients: String, unites: String, quantites: String, prix: String, prix_total: String, nomListeIngredients: String){
        self.codes = codes
        self.ingredients = ingredients
        self.unites = unites
        self.quantites = quantites
        self.prix = prix
        self.prix_total = prix_total
        self.nomListeIngredients = nomListeIngredients
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
