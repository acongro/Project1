import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'recipe_card.dart';
import 'recipe_detail_screen.dart';
import 'meal_planner_screen.dart';
import 'grocery_list_screen.dart';
import 'favorites_screen.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});
  @override
  State<RecipeListScreen> createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  final _tags = const ['vegetarian', 'vegan', 'gluten-free'];
  String _query = '';
  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final filtered = app.recipes
        .where((r) => r.title.toLowerCase().contains(_query.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        actions: [
          IconButton(
            tooltip: 'Favorites',
            icon: const Icon(Icons.favorite),
            onPressed: () =>
                Navigator.pushNamed(context, FavoritesScreen.route),
          ),
          IconButton(
            tooltip: 'Planner',
            icon: const Icon(Icons.calendar_month),
            onPressed: () =>
                Navigator.pushNamed(context, MealPlannerScreen.route),
          ),
          IconButton(
            tooltip: 'Grocery',
            icon: const Icon(Icons.shopping_cart),
            onPressed: () =>
                Navigator.pushNamed(context, GroceryListScreen.route),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search recipes...',
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          SizedBox(
            height: 46,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _tags.length + 1,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (ctx, i) {
                if (i == 0) {
                  return FilterChip(
                    label: const Text('Clear'),
                    selected: app.filters.isEmpty,
                    onSelected: (_) {
                      final toRemove = List.of(app.filters);
                      for (final f in toRemove) app.toggleFilter(f);
                    },
                  );
                }
                final tag = _tags[i - 1];
                final selected = app.filters.contains(tag);
                return FilterChip(
                  label: Text(tag),
                  selected: selected,
                  onSelected: (_) => app.toggleFilter(tag),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final r = filtered[i];
                return RecipeCard(
                  recipe: r,
                  onTap: () => Navigator.pushNamed(
                    context,
                    RecipeDetailScreen.route,
                    arguments: r.id,
                  ),
                  onLongPress: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Hold to quick-favorite ${r.title}')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
