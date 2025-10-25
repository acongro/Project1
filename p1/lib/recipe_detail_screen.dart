import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'app_state.dart';
import 'recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  static const route = '/recipe';
  const RecipeDetailScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as String;
    final app = context.watch<AppState>();
    final Recipe recipe = app.byId(id)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
        actions: [
          IconButton(
            tooltip: 'Share',
            icon: const Icon(Icons.share),
            onPressed: () => Share.share(
              '${recipe.title}\n\nIngredients:\n- ${recipe.ingredients.join('\n- ')}\n\nSteps:\n${recipe.steps.asMap().entries.map((e) => '${e.key + 1}. ${e.value}').join('\n')}',
              subject: 'Recipe: ${recipe.title}',
            ),
          ),
          IconButton(
            tooltip: 'Favorite',
            icon: Icon(app.isFavorite(recipe.id)
                ? Icons.favorite
                : Icons.favorite_border),
            onPressed: () => app.toggleFavorite(recipe.id),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add to Planner'),
        onPressed: () async {
          final meal = await _pickMeal(context);
          if (meal == null) return;
          final date = DateTime.now();
          final dateKey =
              '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
          app.setMeal(dateKey, meal, recipe.id);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Added to today’s plan')),
          );
        },
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(recipe.imageUrl, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(spacing: 8, children: [
                  Chip(label: Text('${recipe.minutes} min')),
                  Chip(label: Text('Serves ${recipe.servings}')),
                  Chip(label: Text(recipe.difficulty)),
                ]),
                const SizedBox(height: 12),
                Text('Ingredients',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                ...recipe.ingredients.map((i) => Row(
                      children: [
                        const Icon(Icons.check_box_outline_blank, size: 18),
                        const SizedBox(width: 8),
                        Expanded(child: Text(i)),
                      ],
                    )),
                const SizedBox(height: 16),
                Text('Steps', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                ...recipe.steps.asMap().entries.map(
                      (e) => ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          radius: 12,
                          child: Text('${e.key + 1}'),
                        ),
                        title: Text(e.value),
                      ),
                    ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<MealType?> _pickMeal(BuildContext context) async {
    return showModalBottomSheet<MealType>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: MealType.values
              .map((m) => ListTile(
                    leading: const Icon(Icons.add),
                    title: Text(m.name[0].toUpperCase() + m.name.substring(1)),
                    onTap: () => Navigator.pop(ctx, m),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
