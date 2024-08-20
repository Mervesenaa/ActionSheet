//
//  ItemManager.swift
//  ActionSheet
//
//  Created by Merve Sena on 20.08.2024.
//

import Foundation

struct Item: Identifiable, Codable {
    var id = UUID()
    var name: String
}

class ItemManager: ObservableObject {
    @Published var items: [Item] = []

    private let itemsKey = "items"

    init() {
        loadItems()
    }

    func loadItems() {
        if let data = UserDefaults.standard.data(forKey: itemsKey),
           let decodedItems = try? JSONDecoder().decode([Item].self, from: data) {
            items = decodedItems
        } else {
            // Varsayılan öğeler
            items = [
                Item(name: "Item 1"),
                Item(name: "Item 2"),
                Item(name: "Item 3")
            ]
        }
    }

    func saveItems() {
        if let encodedItems = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedItems, forKey: itemsKey)
        }
    }

    func addItem(_ item: Item) {
        items.append(item)
        saveItems()
    }

    func updateItem(_ updatedItem: Item) {
        if let index = items.firstIndex(where: { $0.id == updatedItem.id }) {
            items[index] = updatedItem
            saveItems()
        }
    }

    func deleteItem(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        saveItems()
    }

    func deleteItem(_ item: Item) {
        items.removeAll { $0.id == item.id }
        saveItems()
    }
}
