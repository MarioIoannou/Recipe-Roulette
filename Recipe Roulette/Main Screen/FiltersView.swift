//
//  FiltersView.swift
//  Recipe Roulette
//
//  Created by Marios Ioannou on 22/10/24.
//

import SwiftUI

struct FiltersView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedDiet = Set<String>()
    let diets = ["Vegetarian", "Vegan", "Ketogenic", "Gluten-Free", "Pescetarian", "Lacto-Vegetarian", "Ovo-Vegetarian", "Paleo", "Whole30", "Primal", "Low FODMAP"]
    
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Dietary Restrictions")) {
                    ForEach(diets, id: \.self) { diet in
                        MultipleSelectionRow(title: diet, isSelected: selectedDiet.contains(diet)) {
                            if selectedDiet.contains(diet) {
                                selectedDiet.remove(diet)
                            } else {
                                selectedDiet.insert(diet)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Filters", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                viewModel.filters.dietaryRestrictions = Array(selectedDiet)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct MultipleSelectionRow: View {
    var title: String
    var isSelected: Bool
    var action: ()->Void
    
    var body: some View {
        Button(action: self.action) {
            HStack {
                Text(title)
                if isSelected {
                    Spacer()
                    Image(systemName: "checkmark")
                }
            }
        }
    }
}
