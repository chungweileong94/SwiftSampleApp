//
//  ContentView.swift
//  SwiftSampleApp
//
//  Created by Chung Wei Leong on 02/07/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var dataModel = DataModel()
    
    var body: some View {
        NavigationStack {
            List(Category.allCases) { category in
                Section(category.localizedName) {
                    ForEach(dataModel.recipes(in: category)) { recipe in
                        NavigationLink(recipe.name, value: recipe)
                    }
                }
            }
            .navigationTitle("Categories")
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
        }
        .environmentObject(dataModel)
    }
}

//#Preview {
//    ContentView()
//}
