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
    var nomProgression: String?
}

protocol SheetCompleteObserver {
    func changed(nomRecette: String, idFiche: Int)
    func changed(nomAuteur: String)
    func changed(category: String)
    func changed(couverts: Int)
}

enum SheetPropertyChange {
    case NOM
    case AUTEUR
    case CATEGORY
    case COUVERT
}

class SheetComplete: ObservableObject {
    private var observers: [SheetCompleteObserver] = []
    public var idFiche: Int
    @Published var nomRecette : String {
        didSet {
            if(nomRecette.count < 1 ){
                nomRecette = oldValue
            }
            notifyObservers(sh: .NOM)
        }
    }
    @Published var nomAuteur: String {
        didSet {
            if(nomAuteur.count < 1 ){
                nomAuteur = oldValue
            }
            notifyObservers(sh: .AUTEUR)
        }
    }
    @Published var Nbre_couverts: Int {
        didSet {
            if(Nbre_couverts == nil ){
                Nbre_couverts = oldValue
            }
            notifyObservers(sh: .COUVERT)
        }
    }
    @Published var categorieRecette: String {
        didSet {
            if(categorieRecette.count < 1){
                categorieRecette = oldValue
            }
            notifyObservers(sh: .CATEGORY)
        }
    }
    @Published var nomProgression: String
    /*
    */
    
    init(nomRecette: String, idFiche: Int, nomAuteur: String, Nbre_couverts: Int, categorieRecette: String, nomProgression: String){
        self.nomRecette = nomRecette
        self.idFiche = idFiche
        self.nomAuteur = nomAuteur
        self.Nbre_couverts = Nbre_couverts
        self.categorieRecette = categorieRecette
        self.nomProgression = nomProgression
    }
    
    func addObserver(obs: SheetCompleteObserver){
        observers.append(obs)
    }
    
    func notifyObservers(sh: SheetPropertyChange){
        for observer in observers {
            switch sh {
                case .NOM:
                observer.changed(nomRecette: nomRecette, idFiche: idFiche)
                case .AUTEUR:
                    observer.changed(nomAuteur: nomAuteur)
                case .CATEGORY:
                    observer.changed(category: categorieRecette)
            case .COUVERT:
                observer.changed(couverts: Nbre_couverts)
            }
        }
    }
}
