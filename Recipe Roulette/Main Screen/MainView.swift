//
//  MainView.swift
//  Recipe Roulette
//
//  Created by Marios Ioannou on 22/10/24.
//

import SwiftUI

struct MainView: View {
    @State private var showFilters = false
    @ObservedObject var viewModel = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Recipe Roulette")
                    .font(.largeTitle)
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    viewModel.fetchRandomRecipe()
                }) {
                    Text("Spin the Wheel")
                        .font(.title)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
                
                if let recipe = viewModel.selectedRecipe {
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        Text("View Recipe")
                            .font(.headline)
                    }
                    .padding()
                }
                
                Spacer()
            }
            .navigationBarItems(trailing: Button(action: {
                showFilters.toggle()
            }) {
                Image(systemName: "slider.horizontal.3")
            })
            .sheet(isPresented: $showFilters) {
                FiltersView(viewModel: viewModel)
            }
        }
    }
}
