//
//  RecipeDetailView.swift
//  SwiftSampleApp
//
//  Created by Chung Wei Leong on 02/07/2023.
//

import SwiftUI

struct LabelValueView: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
            Text(value)
                .foregroundStyle(.secondary)
        }
    }
}

struct RecipeDetailView: View {
    @EnvironmentObject private var dataModel: DataModel
    var recipe: Recipe
    
    var body: some View {
        List {
            Section("Basic Information") {
                LabelValueView(
                    label: "Name",
                    value: recipe.name
                )
                LabelValueView(
                    label: "Related Recipes Count",
                    value: recipe.related.count > 0 ? String(recipe.related.count) : "None"
                )
            }
            
            if !recipe.related.isEmpty {
                Section("Related Recipes") {
                    ForEach(recipe.related.compactMap { dataModel.getRecipe(byId: $0) }) { relatedRecipe in
                        NavigationLink(relatedRecipe.name, value: relatedRecipe)
                    }
                }
            }
        }
        .navigationTitle(recipe.name)
    }
}
