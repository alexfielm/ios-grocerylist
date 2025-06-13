import SwiftUI
import SwiftData

@Model
class Grocery{
    var groceryName: String
    var groceryQuantity: Int
    
    init (groceryName: String, groceryQuantity: Int){
        self.groceryName = groceryName
        self.groceryQuantity = groceryQuantity
    }
}
