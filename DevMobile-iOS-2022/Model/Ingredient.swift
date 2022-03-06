//
//  Track.swift
//  Test_Cours_listUI
//
//  Created by m1 on 08/02/2022.
//

import Foundation

struct IngredientDTO: Decodable {
    var idIngredient: Int
    var libelle: String
    var libelleCategorie: String
    var quantiteStockee: Float?
    var prixUnitaire : Float
    var allergene: String
    var idCategorieIngredient: Int
    var idCategorieAllergene: String?
    var unite: String
}

struct IngredientSheetDTO: Decodable {
    var idIngredient: Int
    var libelle: String
}

class IngredientSheet: ObservableObject {
    @Published var idIngredient: Int
    @Published var libelle : String
    
    init(libelle: String, idIngredient: Int){
        self.libelle = libelle
        self.idIngredient = idIngredient
    }
}

protocol IngredientObserver{
    func changed(libelle: String, idIngredient: Int)
    func changed(categorie: Int, idIngredient: Int)
    func changed(quantite: Float, idIngredient: Int)
    func changed(prix: Float, idIngredient: Int)
}

enum IngredientPropertyChange {
    case LIBELLE
    case CATEGORIE
    case QUANTITE
    case PRIX
}

class Ingredient: ObservableObject{
    private var observers: [IngredientObserver] = []
    @Published var idIngredient: Int
    @Published var libelle : String {
        didSet {
            if(libelle.count < 1 ){
                libelle = oldValue
            }
            notifyObservers(ing: .LIBELLE)
        }
    }
    
    @Published var nomCategorie: String
    @Published var quantiteStockee: Float? {
        didSet{
            if(quantiteStockee == nil ){
             quantiteStockee = oldValue
             }
            notifyObservers(ing: .QUANTITE)
        }
    }
    
    @Published var prixUnitaire : Float {
        didSet {
            if(prixUnitaire == nil ){
             prixUnitaire = oldValue
             }
            notifyObservers(ing: .PRIX)
        }
    }
    @Published var allergene: String
    @Published var idCategorieIngredient: Int  {
        didSet {
            notifyObservers(ing: .CATEGORIE)
        }
    }
    @Published var idCategorieAllergene: String?
    @Published var unite: String
    
    init(libelle: String, idIngredient: Int, nomCategorie: String, quantite: Float?, prix: Float, allergene: String, idCategorie: Int, idCatAllergene: String?, unite: String){
        self.libelle = libelle
        self.idIngredient = idIngredient
        self.nomCategorie = nomCategorie
        self.quantiteStockee = quantite
        self.allergene = allergene
        self.prixUnitaire = prix
        self.idCategorieAllergene = idCatAllergene
        self.unite = unite
        self.idCategorieIngredient = idCategorie
    }
    
    func addObserver(obs: IngredientObserver){
        observers.append(obs)
    }
    
    func notifyObservers(ing: IngredientPropertyChange){
        for observer in observers {
            switch ing {
            case .LIBELLE:
                observer.changed(libelle: libelle, idIngredient: idIngredient)
            case .CATEGORIE:
                observer.changed(categorie: idCategorieIngredient, idIngredient: idIngredient)
            case .PRIX:
                observer.changed(prix: prixUnitaire, idIngredient: idIngredient)
            case .QUANTITE:
                observer.changed(quantite: quantiteStockee ?? 0.0, idIngredient: idIngredient)
            }
            
        }
    }
}
