//
//  TrackViewModel.swift
//  Test_Cours_listUI
//
//  Created by m1 on 16/02/2022.
//

import Foundation
import Combine

enum SheetCompleteError: Error, Equatable, CustomStringConvertible {
    case NONE
    /*case TRACKNAME(String)
    case ARTISTNAME(String)
    case COLLECTIONNAME(String)*/
    
    var description: String {
        switch self {
            case .NONE:
                    return "No error"
            /*case .TRACKNAME:
                    return "Trackname isn't  valid"
            case .ARTISTNAME:
                    return "Artist name isn't valid"
            case .COLLECTIONNAME:
                return "Collection name isn't valid"*/
        }
    }
}

class SheetCompleteViewModel: ObservableObject, Subscriber {
    typealias Input = SheetCompleteIntentState
    typealias Failure = Never
    
    private(set) var sheet: SheetComplete
    public var idFiche: Int
    @Published var nomRecette : String
    @Published var nomAuteur: String
    @Published var Nbre_couverts: Int
    @Published var categorieRecette: String
    @Published var nomProgression: String    //@Published var collectionName: String
    @Published var error: SheetCompleteError = .NONE
    var delegate: SheetCompleteViewModelDelegate?
    
    init(sheet: SheetComplete){
        self.sheet = sheet
        self.idFiche = sheet.idFiche
        self.nomRecette = sheet.nomRecette
        self.nomAuteur = sheet.nomAuteur
        self.Nbre_couverts = sheet.Nbre_couverts
        self.categorieRecette = sheet.categorieRecette
        self.nomProgression = sheet.nomProgression
        /*self.trackName = track.trackName
        self.artistName = track.artistName
        self.collectionName = track.collectionName*/
        /*self.track.addObserver(obs: self)*/
    }
    
    /*func changed(trackName: String) {
        self.trackName = trackName
    }
    
    func changed(collectionName: String) {
        self.collectionName = collectionName
    }
    
    func changed(artistName: String) {
        self.artistName = artistName
    }*/
    
    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(_ input: SheetCompleteIntentState) -> Subscribers.Demand {
        switch input {
            case .READY:
                break
            /*case .CHANGING_ARTISTNAME(let artistName):
                self.track.artistName = artistName
                if(self.track.artistName != artistName){
                    self.error = .ARTISTNAME("Invalid input")
                }*/
            case .LIST_UPDATED:
                self.delegate?.sheetCompleteViewModelChanged()
                break
        }
        
        return .none
    }
}

