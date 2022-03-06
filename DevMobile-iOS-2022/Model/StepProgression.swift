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


class StepProgression: ObservableObject {
    
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
    public var id: Int
    
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
    
}
