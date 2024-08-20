//
//  EditItemView.swift
//  ActionSheet
//
//  Created by Merve Sena on 20.08.2024.
//

import SwiftUI

struct EditItemView: View {
    var item: Item
    @Binding var newName: String
    var onSave: () -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Item")) {
                    TextField("Item Name", text: $newName)
                }
            }
            .navigationBarTitle("Edit Item", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                onSave()
            })
        }
    }
}

#Preview {
    EditItemView(item: Item.init(name: "Item 1"), newName: .constant("Item Updated"), onSave: {
            print("Save button tapped")
        }
    )
}
