import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var groceries: [Grocery]
    var body: some View {
        NavigationStack{
            List{
                ForEach(groceries){ groceries in
                    Text(groceries.groceryName)
                        .italic()
                        .padding(.top, 4)
                }
            }.navigationTitle(Text("Grocery List"))
        }
    }
}

#Preview("Test"){
    let container = try! ModelContainer(for: Grocery.self, configurations:ModelConfiguration(isStoredInMemoryOnly: true))
    container.mainContext.insert(Grocery(groceryName: "Potato", groceryQuantity: 4))
    container.mainContext.insert(Grocery(groceryName: "Milk", groceryQuantity: 2))
    container.mainContext.insert(Grocery(groceryName: "Bread", groceryQuantity: 4))
    
    return ContentView()
        .modelContainer(container)
    
}

#Preview("Main"){
    ContentView()
        .modelContainer(for: Grocery.self, inMemory: true)
}
