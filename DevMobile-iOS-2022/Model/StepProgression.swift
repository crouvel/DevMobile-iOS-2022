import Foundation

struct StepProgressionDTO: Decodable{
   
    var id1 : Int
    var titre1: String
    var ordre1: Int
    var temps1: Int
    var description1: String?
    var titre2: String?
    var ordre2: Int?
     var temps2: Int?
     var description2: String?
    var id2: Int?
    
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

class StepProgression: ObservableObject {
    /*private var observers: [TrackObserver] = []*/
    public var id1 : Int
    public var titre1: String
   public var ordre1: Int
   public var temps1: Int
   public var description1: String?
    public var id2: Int?
   public var titre2: String?
   public var ordre2: Int?
   public var temps2: Int?
   public  var description2: String?
    public var id: Int/*@Published var trackName: String {
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
    
    init(id1: Int, titre1: String, ordre1: Int, temps1: Int, description1: String? ,id2: Int?, titre2: String?, ordre2: Int?, temps2: Int?, description2: String?, id: Int){
        self.id1 = id1
        self.id2 = id2
        self.titre1 = titre1
        self.ordre1 = ordre1
        self.temps1 = temps1
        self.description1 = description1
        self.titre2 = titre2
        self.ordre2 = ordre2
        self.temps2 = temps2
        self.description2 = description2
        self.id = id
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
