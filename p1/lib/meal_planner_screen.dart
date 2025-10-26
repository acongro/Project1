import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'recipe.dart';
import 'recipe_detail_screen.dart';

class MealPlannerScreen extends StatefulWidget {
  static const route = '/planner';
  const MealPlannerScreen({super.key});

  @override
  State<MealPlannerScreen> createState() => _MealPlannerScreenState();
}

class _MealPlannerScreenState extends State<MealPlannerScreen> {
  late DateTime start;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    // Start from Sunday of this week
    start = now.subtract(Duration(days: now.weekday % 7));
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final days = List.generate(7, (i) => start.add(Duration(days: i)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Planner (Week)'),
        actions: [
          IconButton(
            tooltip: 'Generate Grocery List',
            icon: const Icon(Icons.shopping_cart_checkout),
            onPressed: () {
              app.regenerateGroceryList();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Grocery list generated')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Day')),
            DataColumn(label: Text('Breakfast')),
            DataColumn(label: Text('Lunch')),
            DataColumn(label: Text('Dinner')),
          ],
          rows: days.map((d) {
            final key = _dateKey(d);
            return DataRow(cells: [
              DataCell(Text('${d.month}/${d.day}')),
              DataCell(_slot(context, app, key, MealType.breakfast)),
              DataCell(_slot(context, app, key, MealType.lunch)),
              DataCell(_slot(context, app, key, MealType.dinner)),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  Widget _slot(
      BuildContext context, AppState app, String dateKey, MealType meal) {
    final id = app.mealPlan[dateKey]?[meal.name];
    if (id == null) {
      return TextButton.icon(
        icon: const Icon(Icons.add),
        label: const Text('Add'),
        onPressed: () => _chooseRecipe(context, app, dateKey, meal),
      );
    }
    final r = app.byId(id)!;
    return InkWell(
      onTap: () => Navigator.pushNamed(context, RecipeDetailScreen.route,
          arguments: r.id),
      child: Row(
        children: [
          const Icon(Icons.restaurant_menu, size: 16),
          const SizedBox(width: 6),
          Flexible(child: Text(r.title)),
          IconButton(
            tooltip: 'Replace / Clear',
            icon: const Icon(Icons.swap_horiz),
            onPressed: () => _chooseRecipe(context, app, dateKey, meal),
          ),
        ],
      ),
    );
  }

  Future<void> _chooseRecipe(
      BuildContext context, AppState app, String dateKey, MealType meal) async {
    final chosen = await showDialog<_Choice>(
      context: context,
      builder: (ctx) {
        final items = app.recipes;
        return SimpleDialog(
          title: const Text('Select Recipe'),
          children: [
            SimpleDialogOption(
              onPressed: () => Navigator.pop(ctx, const _Choice.clear()),
              child: const Text('None (clear)'),
            ),
            const Divider(height: 0),
            ...items.map((r) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(ctx, _Choice.assign(r.id)),
                  child: Text(r.title),
                )),
          ],
        );
      },
    );

    if (chosen == null) return;
    if (chosen.clear) {
      app.clearMeal(dateKey, meal);
    } else if (chosen.recipeId != null) {
      app.setMeal(dateKey, meal, chosen.recipeId!);
    }
  }

  String _dateKey(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

class _Choice {
  final bool clear;
  final String? recipeId;
  const _Choice._(this.clear, this.recipeId);
  const _Choice.clear() : this._(true, null);
  const _Choice.assign(this.recipeId) : clear = false;
}
