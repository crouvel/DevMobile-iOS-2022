//
//  TracksIntent.swift
//  Test_Cours_listUI
//
//  Created by m1 on 19/02/2022.
//

import Foundation

enum SheetListState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded([SheetCompleteDTO])
    case loadingError(String)
    
    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .loading(let s)                      : return "loading"
        case .loaded(let sheets)                  : return "loaded: \(sheets.count) incomplete sheets"
        case .loadingError(let error)             : return "loadingError: Error loading -> \(error)"
        }
    }
    
}

class SheetListViewIntent{
    
    var sheetincompleteList: SheetIncompleteListViewModel
    
    init(list: SheetIncompleteListViewModel){
        self.sheetincompleteList = list
    }
    
    func loaded(sheets: [SheetComplete]){

        debugPrint("SearchIntent: \(self.sheetincompleteList.sheetListState) => \(sheets.count) editors loaded")

        self.sheetincompleteList.sheetListState = .ready
    }
    
    func httpJsonLoaded(results: [SheetCompleteDTO]){

        debugPrint("SearchIntent: httpJsonLoaded -> success -> .loaded")

        sheetincompleteList.sheetListState = .loaded(results)
    }
    
    func httpJsonLoadedError(error: Error){
        sheetincompleteList.sheetListState = .loadingError("\(error)")
    }
    
    func sheetsLoaded(){

        debugPrint("SearchIntent: sheets loaded")

        sheetincompleteList.sheetListState = .ready
    }
    
    
    func load(url : String){

        debugPrint("SearchIntent: .loading(\(url))")

        sheetincompleteList.sheetListState = .loading(url)
    }
    
    
}
