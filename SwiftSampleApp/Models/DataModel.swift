//
//  DataModel.swift
//  SwiftSampleApp
//
//  Created by Chung Wei Leong on 02/07/2023.
//

import Foundation
import SwiftUI

class DataModel: ObservableObject {
    @Published var recipes: [Recipe] = builtInRecipes
    
    func recipes(in category: Category?) -> [Recipe] {
        recipes
            .filter { $0.category == category }
            .sorted { $0.name < $1.name }
    }
    
    func getRecipe(byId recipeId: Recipe.ID) -> Recipe? {
        recipes.first { recipe in
            recipe.id == recipeId
        }
    }
}

enum Category: Int, CaseIterable, Identifiable, Hashable {
    case dessert
    case pancake
    case salad
    case sandwich
    
    var id: Int { rawValue }
    
    var localizedName: LocalizedStringKey {
        switch self {
        case .dessert:
            return "Dessert"
        case .pancake:
            return "Pancake"
        case .salad:
            return "Salad"
        case .sandwich:
            return "Sandwich"
        }
    }
}

struct Recipe: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var category: Category
    var ingredients: [Ingredient]
    var related: [Recipe.ID] = []
    var imageName: String? = nil
}

struct Ingredient: Hashable, Identifiable {
    let id = UUID()
    var description: String
    
    static func fromLines(_ lines: String) -> [Ingredient] {
        lines.split(separator: "\n", omittingEmptySubsequences: true)
            .map { Ingredient(description: String($0)) }
    }
}

let builtInRecipes: [Recipe] = {
    var recipes = [
        "Apple Pie": Recipe(
            name: "Apple Pie", category: .dessert,
            ingredients: Ingredient.fromLines(applePie)),
        "Baklava": Recipe(
            name: "Baklava", category: .dessert,
            ingredients: []),
        "Bolo de Rolo": Recipe(
            name: "Bolo de rolo", category: .dessert,
            ingredients: []),
        "Chocolate Crackles": Recipe(
            name: "Chocolate crackles", category: .dessert,
            ingredients: []),
        "Crème Brûlée": Recipe(
            name: "Crème brûlée", category: .dessert,
            ingredients: []),
        "Fruit Pie Filling": Recipe(
            name: "Fruit Pie Filling", category: .dessert,
            ingredients: []),
        "Kanom Thong Ek": Recipe(
            name: "Kanom Thong Ek", category: .dessert,
            ingredients: []),
        "Mochi": Recipe(
            name: "Mochi", category: .dessert,
            ingredients: []),
        "Marzipan": Recipe(
            name: "Marzipan", category: .dessert,
            ingredients: []),
        "Pie Crust": Recipe(
            name: "Pie Crust", category: .dessert,
            ingredients: Ingredient.fromLines(pieCrust)),
        "Shortbread Biscuits": Recipe(
            name: "Shortbread Biscuits", category: .dessert,
            ingredients: []),
        "Tiramisu": Recipe(
            name: "Tiramisu", category: .dessert,
            ingredients: []),
        "Crêpe": Recipe(
            name: "Crêpe", category: .pancake, ingredients: []),
        "Jianbing": Recipe(
            name: "Jianbing", category: .pancake, ingredients: []),
        "American": Recipe(
            name: "American", category: .pancake, ingredients: []),
        "Dosa": Recipe(
            name: "Dosa", category: .pancake, ingredients: []),
        "Injera": Recipe(
            name: "Injera", category: .pancake, ingredients: []),
        "Acar": Recipe(
            name: "Acar", category: .salad, ingredients: []),
        "Ambrosia": Recipe(
            name: "Ambrosia", category: .salad, ingredients: []),
        "Bok l'hong": Recipe(
            name: "Bok l'hong", category: .salad, ingredients: []),
        "Caprese": Recipe(
            name: "Caprese", category: .salad, ingredients: []),
        "Ceviche": Recipe(
            name: "Ceviche", category: .salad, ingredients: []),
        "Çoban salatası": Recipe(
            name: "Çoban salatası", category: .salad, ingredients: []),
        "Fiambre": Recipe(
            name: "Fiambre", category: .salad, ingredients: []),
        "Kachumbari": Recipe(
            name: "Kachumbari", category: .salad, ingredients: []),
        "Niçoise": Recipe(
            name: "Niçoise", category: .salad, ingredients: []),
    ]
    
    recipes["Apple Pie"]!.related = [
        recipes["Pie Crust"]!.id,
        recipes["Fruit Pie Filling"]!.id,
    ]
    
    recipes["Pie Crust"]!.related = [recipes["Fruit Pie Filling"]!.id]
    recipes["Fruit Pie Filling"]!.related = [recipes["Pie Crust"]!.id]
    
    return Array(recipes.values)
}()

let applePie = """
    ¾ cup white sugar
    2 tablespoons all-purpose flour
    ½ teaspoon ground cinnamon
    ¼ teaspoon ground nutmeg
    ½ teaspoon lemon zest
    7 cups thinly sliced apples
    2 teaspoons lemon juice
    1 tablespoon butter
    1 recipe pastry for a 9 inch double crust pie
    4 tablespoons milk
    """

let pieCrust = """
    2 ½ cups all purpose flour
    1 Tbsp. powdered sugar
    1 tsp. sea salt
    ½ cup shortening
    ½ cup butter (Cold, Cut Into Small Pieces)
    ⅓ cup cold water (Plus More As Needed)
    """
