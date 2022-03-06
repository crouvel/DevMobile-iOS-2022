//
//  ProgressionViewModel.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 28/02/2022.
//

import Foundation


class ProgressionToCreateViewModel : ObservableObject{
    
    private(set) var progression: ProgressionToCreate
    @Published var referenceProgression: String
    
    init(progression: ProgressionToCreate){
        self.progression = progression
        self.referenceProgression = progression.referenceProgression
    }
    
}

class ProgressionViewModel : ObservableObject{
    
    private(set) var progression: Progression
    @Published var referenceProgression: String
    public var idProgression: Int
    
    
    init(progression: Progression){
        self.progression = progression
        self.referenceProgression = progression.referenceProgression
        self.idProgression = progression.idProgression
    }
    
}
