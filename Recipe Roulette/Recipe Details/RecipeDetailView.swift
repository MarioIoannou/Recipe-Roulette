//
//  Recipe.swift
//  Recipe Roulette
//
//  Created by Marios Ioannou on 22/10/24.
//

import SwiftUI

struct RecipeDetailView: View {
    
    let recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                if let imageUrl = recipe.image, let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)
                }
                
                Text(recipe.title)
                    .font(.title)
                    .padding(.vertical)
                
                HStack {
                    Text("Ready in \(recipe.readyInMinutes) minutes")
                    Spacer()
                    Text("Serves \(recipe.servings)")
                }
                .padding(.bottom)
                
                Text("Ingredients")
                    .font(.headline)
                    .padding(.vertical)
                
                ForEach(recipe.extendedIngredients) { ingredient in
                    Text("• \(ingredient.amount, specifier: "%.1f") \(ingredient.unit) \(ingredient.name)")
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Text("Instructions")
                    .font(.headline)
                    .padding(.vertical)
                
                if let instructions = recipe.instructions {
                    Text(instructions)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .font(.body)
                        .lineLimit(nil)
                } else {
                    Text("No instructions available.")
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .navigationBarTitle(Text(recipe.title), displayMode: .inline)
    }
}
