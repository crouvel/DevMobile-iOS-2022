//
//  ProgressionIntent.swift
//  DevMobile-iOS-2022
//
//  Created by m1 on 28/02/2022.
//

import Foundation

enum ProgressionState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded([Ingredient])
    case loadingError(String)

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .loading(let s)                      : return "loading"
        case .loaded(let progression)                  : return "loaded: \(progression.count) ingredients"
        case .loadingError(let error)             : return "loadingError: Error loading -> \(error)"
        }
    }
    
}

/*class ProgressionIntent : ObservableObject {
        
    func created(){
        #if DEBUG
        debugPrint("SearchIntent: \(self.creationState) => progression created")
        #endif
        self.creationState = .ready
    }
    
    func httpJsonLoaded(results: [SheetCompleteDTO]){
            #if DEBUG
            debugPrint("SearchIntent: httpJsonLoaded -> success -> .loaded(editors)")
            #endif
            sheetincompleteList.sheetListState = .loaded(results)
            }else{
                sheetincompleteList.sheetListState = .loadingError("\(error)")
            }
    }

    func creatingError(error: String){
        self.creationState = .creatingError("\(error)")
}

    func progressionCreated(){
        #if DEBUG
        debugPrint("SearchIntent: editor deleted => save data")
        #endif
        self.creationState = .created
    }

    //var editeurFilter : String? = nil

    func loadEditeurs(url : String/*, editeurFilter: String?*/){
        //self.editeurFilter = editeurFilter
        #if DEBUG
        debugPrint("SearchIntent: .loading(\(url))")
        debugPrint("SearchIntent: asyncLoadEditors")
        #endif
        sheetincompleteList.sheetListState = .loading(url)
    }
    
}*/

