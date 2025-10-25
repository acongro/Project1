import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sample_recipes.dart';
import 'recipe.dart';

enum MealType { breakfast, lunch, dinner }

class AppState extends ChangeNotifier {
  final List<Recipe> _all = List.of(sampleRecipes);
  final Set<String> _filters = {};
  final Set<String> _favorites = {};
  final Map<String, Map<String, String>> _mealPlan = {};
  final Map<String, int> _groceryCounts = {};
  final Set<String> _groceryChecked = {};
  List<Recipe> get recipes {
    if (_filters.isEmpty) return _all;
    return _all
        .where((r) => _filters.every((f) => r.tags.contains(f)))
        .toList();
  }

  Set<String> get filters => _filters;
  Set<String> get favorites => _favorites;
  Map<String, Map<String, String>> get mealPlan => _mealPlan;
  Map<String, int> get groceryCounts => _groceryCounts;
  Set<String> get groceryChecked => _groceryChecked;
  void toggleFilter(String tag) {
    if (_filters.contains(tag)) {
      _filters.remove(tag);
    } else {
      _filters.add(tag);
    }
    notifyListeners();
  }

  bool isFavorite(String id) => _favorites.contains(id);
  void toggleFavorite(String id) {
    if (_favorites.contains(id)) {
      _favorites.remove(id);
    } else {
      _favorites.add(id);
    }
    saveToStorage();
    notifyListeners();
  }

  Recipe? byId(String id) =>
      _all.firstWhere((r) => r.id == id, orElse: () => _all.first);
  void setMeal(String dateKey, MealType meal, String recipeId) {
    _mealPlan.putIfAbsent(dateKey, () => {});
    _mealPlan[dateKey]![meal.name] = recipeId;
    saveToStorage();
    notifyListeners();
  }

  void clearMeal(String dateKey, MealType meal) {
    if (_mealPlan.containsKey(dateKey)) {
      _mealPlan[dateKey]!.remove(meal.name);
      if (_mealPlan[dateKey]!.isEmpty) {
        _mealPlan.remove(dateKey);
      }
      saveToStorage();
      notifyListeners();
    }
  }

  void regenerateGroceryList() {
    _groceryCounts.clear();
    _groceryChecked.clear();
    _mealPlan.forEach((_, slots) {
      for (final recipeId in slots.values) {
        final recipe = _all.firstWhere((r) => r.id == recipeId);
        for (final item in recipe.ingredients) {
          final normalized = item.trim().toLowerCase();
          _groceryCounts.update(normalized, (v) => v + 1, ifAbsent: () => 1);
        }
      }
    });
    notifyListeners();
  }

  void toggleGroceryChecked(String itemKey) {
    if (_groceryChecked.contains(itemKey)) {
      _groceryChecked.remove(itemKey);
    } else {
      _groceryChecked.add(itemKey);
    }
    notifyListeners();
  }

  void clearGroceryList() {
    _groceryCounts.clear();
    _groceryChecked.clear();
    notifyListeners();
  }

  Future<void> loadFromStorage() async {
    final sp = await SharedPreferences.getInstance();
    final favStr = sp.getString('favorites');
    final planStr = sp.getString('mealPlan');
    if (favStr != null)
      _favorites.addAll(List<String>.from(jsonDecode(favStr)));
    if (planStr != null) {
      final map = jsonDecode(planStr) as Map<String, dynamic>;
      map.forEach((k, v) => _mealPlan[k] = Map<String, String>.from(v));
    }
  }

  Future<void> saveToStorage() async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString('favorites', jsonEncode(_favorites.toList()));
    await sp.setString('mealPlan', jsonEncode(_mealPlan));
  }
}
