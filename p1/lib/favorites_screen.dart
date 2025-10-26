import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'recipe_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  static const route = '/favorites';
  const FavoritesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final favs = app.favorites.toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favs.isEmpty
          ? const Center(child: Text('No favorites yet. Tap ♥ on a recipe.'))
          : ListView.builder(
              itemCount: favs.length,
              itemBuilder: (_, i) {
                final id = favs[i];
                final r = app.byId(id)!;
                return ListTile(
                  leading: const Icon(Icons.favorite),
                  title: Text(r.title),
                  subtitle: Text('${r.minutes} min • ${r.difficulty}'),
                  onTap: () => Navigator.pushNamed(
                    context,
                    RecipeDetailScreen.route,
                    arguments: r.id,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () => app.toggleFavorite(id),
                  ),
                );
              },
            ),
    );
  }
}
