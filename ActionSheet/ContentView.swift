//
//  ContentView.swift
//  ActionSheet
//
//  Created by Merve Sena on 20.08.2024.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @StateObject private var itemManager = ItemManager()
    @State private var showingActionSheet = false
    @State private var selectedItem: Item?
    @State private var isEditing = false
    @State private var newName: String = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(itemManager.items) { item in
                    Text(item.name)
                        .onTapGesture {
                            selectedItem = item
                            newName = item.name
                            showingActionSheet = true
                        }
                }
                .onDelete(perform: itemManager.deleteItem)
            }
            .navigationBarTitle("Items")
            .toolbar {
                EditButton()
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(
                    title: Text("Edit or Delete Item"),
                    message: Text("What would you like to do?"),
                    buttons: [
                        .default(Text("Edit")) {
                            isEditing = true
                        },
                        .destructive(Text("Delete")) {
                            if let selectedItem = selectedItem {
                                itemManager.deleteItem(selectedItem)
                            }
                        },
                        .cancel()
                    ]
                )
            }
            .sheet(isPresented: $isEditing) {
                if let selectedItem = selectedItem {
                    EditItemView(item: selectedItem, newName: $newName, onSave: {
                        let updatedItem = Item(id: selectedItem.id, name: newName)
                        itemManager.updateItem(updatedItem)
                        isEditing = false
                    })
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
