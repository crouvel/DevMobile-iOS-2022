//
//  TracksIntent.swift
//  Test_Cours_listUI
//
//  Created by m1 on 19/02/2022.
//

import Foundation

enum SheetCompleteListState : CustomStringConvertible{
    case ready
    case loading(String)
    case loaded([SheetComplete])
    case loadingError(String)
    //case newEditeurs([EditeurViewModel])

    var description: String{
        switch self {
        case .ready                               : return "ready"
        case .loading(let s)                      : return "loading"
        case .loaded(let editeurs)                  : return "loaded: \(editeurs.count) ingredients"
        case .loadingError(let error)             : return "loadingError: Error loading -> \(error)"
        //case .newEditeurs(let editeurs)               : return "newJeu: reset game list with \(editeurs.count) editors"
        }
    }
}

/*class SearchEditeurListViewIntent{
    
    @ObservedObject var TrackList : TracksViewModel
    
    init(list: TracksViewModel){
        self.TrackList = list
    }
        
    func loaded(editeurs: [Editeur]){
        #if DEBUG
        debugPrint("SearchIntent: \(self.editeurList.editeurListState) => \(editeurs.count) editors loaded")
        #endif
        self.editeurList.editeurListState = .ready
    }
    
    func httpJsonLoaded(result: Result<[Editeur], HttpRequestError>){
        switch result {
        case let .success(data):
            #if DEBUG
            debugPrint("SearchIntent: httpJsonLoaded -> success -> .loaded(editors)")
            #endif

            editeurList.editeurListState = .loaded(data)

        case let .failure(error):
            editeurList.editeurListState = .loadingError(error)
        }
    }
    
    func editeurLoaded(){
        #if DEBUG
        debugPrint("SearchIntent: editor deleted => save data")
        #endif
        editeurList.editeurListState = .ready
    }

    var editeurFilter : String? = nil

    func loadEditeurs(url : String, editeurFilter: String?){
        self.editeurFilter = editeurFilter
        #if DEBUG
        debugPrint("SearchIntent: .loading(\(url))")
        debugPrint("SearchIntent: asyncLoadEditors")
        #endif
        editeurList.editeurListState = .loading(url)
    }
    

}*/
