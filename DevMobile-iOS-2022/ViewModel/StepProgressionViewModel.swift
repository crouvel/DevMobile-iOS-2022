//
//  StepProgressionViewModel.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 22/02/2022.
//


import Foundation
import Combine

enum StepProgressionError: Error, Equatable, CustomStringConvertible {
    case NONE
   
    
    var description: String {
        switch self {
            case .NONE:
                    return "No error"
        }
    }
}

class StepProgressionViewModel: ObservableObject , Equatable/*Subscriber*/ {
    static func == (lhs: StepProgressionViewModel, rhs: StepProgressionViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    //typealias Input = SheetIntentState
    typealias Failure = Never
    
    private(set) var step: StepProgression
    public var id1 : Int
    public var titre1: String
    public var ordre1: Int
    public var temps1: Int
    public var description1: String?
    public var id2 : Int?
    public var titre2: String?
    public var ordre2: Int?
    public var temps2: Int?
    public  var description2: String?
    public var id: Int
    //@Published var collectionName: String
    @Published var error: StepProgressionError = .NONE
    //var delegate: SheetViewModelDelegate?
    
    init(step: StepProgression){
        self.step = step
        self.id1 = step.id1
        self.titre1 = step.titre1
        self.ordre1 = step.ordre1
        self.temps1 = step.temps1
        self.description1 = step.description1
        self.id2 = step.id2
        self.titre2 = step.titre2
        self.ordre2 = step.ordre2
        self.temps2 = step.temps2
        self.description2 = step.description2
        self.id = step.id
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
    
    /*func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        return
    }
    
    func receive(_ input: SheetIntentState) -> Subscribers.Demand {
        switch input {
            case .READY:
                break
            /*case .CHANGING_ARTISTNAME(let artistName):
                self.track.artistName = artistName
                if(self.track.artistName != artistName){
                    self.error = .ARTISTNAME("Invalid input")
                }*/
            case .LIST_UPDATED:
                self.delegate?.sheetViewModelChanged()
                break
        }
        
        return .none
    }*/
}

