import SwiftUI
import SwiftData



struct ContentView: View {
    func addEssentialFoods(){
        modelContext.insert(Grocery(groceryName: "Potato", groceryQuantity: 4, isBought: true))
        modelContext.insert(Grocery(groceryName: "Milk", groceryQuantity: 2, isBought: false))
        modelContext.insert(Grocery(groceryName: "Bread", groceryQuantity: 4, isBought: .random()))
        
    }
    
    @Environment(\.modelContext) private var modelContext
    @Query private var groceries: [Grocery] //esto muestra en pantalla todo lo que esta en groceries
    var body: some View {
        NavigationStack{
            List{
                ForEach(groceries){ groceries in
                    Text(groceries.groceryName)
                        .padding(.top, 4)
                        .foregroundStyle(groceries.isBought == false ? Color.primary : Color.accentColor)//se pregunta si es false(el producto no esta comprado)si el ingrediente esta comprado (true), se pinta de accentColor (azul)
                        .strikethrough(groceries.isBought)//si el producto esta comprado se tacha
                        .italic(groceries.isBought)
                        //agregamos acciones al deslizar sobre el grocerie
                        .swipeActions {
                            Button(role: .destructive) { //el boton tiene accion de borrado
                                withAnimation {
                                    modelContext.delete(groceries)
                                }
                            }label: {
                                Label("Delete", systemImage: "trash")
                            }
                            
                        }
                        //agregamos otra accion de swipe, para marcar y desmarcar el grocerie
                        .swipeActions(edge: .leading) {
                            //si isBought is false aparece un checkmark, si es true aparece una x para desmarcar
                            Button("Done", systemImage: groceries.isBought == false ? "checkmark.circle":"x.circle"){
                                groceries.isBought.toggle()
                            }.tint(groceries.isBought == false ? .green : .accentColor)
                        }
                }
            }.navigationTitle(Text("Grocery List"))
            //creamos una barra superior para poner un boton de agregar groceries
                .toolbar{
                    if groceries.isEmpty{//si la lista groceries esta vacia
                        ToolbarItem{//crea un item en la toolbar
                            Button{
                                addEssentialFoods()//cuando presionemos el boton llama a la funcion que llena automaticamente con unos groceries
                            }label:{
                                Label("Essentials", systemImage: "carrot")//ponemos una img para el boton
                            }
                        }
                    }
                }
                .overlay{
                    if groceries.isEmpty{
                        ContentUnavailableView("Empty cart", systemImage: "cart.circle", description: Text("Add new groceries to your cart"))
                    }
                }
        }
    }
}
#Preview("Test with sample data"){
    let sampleData: [Grocery] = [
        Grocery(groceryName: "Potato", groceryQuantity: 4, isBought: true),
        Grocery(groceryName: "Milk", groceryQuantity: 2, isBought: false),
        Grocery(groceryName: "Bread", groceryQuantity: 4, isBought: .random())
    ]
    let container = try! ModelContainer(for: Grocery.self, configurations:ModelConfiguration(isStoredInMemoryOnly: true))
    for item in sampleData{
        container.mainContext.insert(item)
    }
    
    return ContentView()
        .modelContainer(container)
    
}
#Preview("Main"){
    ContentView()
        .modelContainer(for: Grocery.self, inMemory: true)
}
