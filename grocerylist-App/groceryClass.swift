import SwiftUI
import SwiftData

@Model
class Grocery{
    var groceryName: String
    var groceryQuantity: Int
    var isBought: Bool
    
    init (groceryName: String, groceryQuantity: Int, isBought: Bool){
        self.groceryName = groceryName
        self.groceryQuantity = groceryQuantity
        self.isBought = isBought
    }
}
