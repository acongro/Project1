import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'app_state.dart';

class GroceryListScreen extends StatelessWidget {
  static const route = '/grocery';
  const GroceryListScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final items = app.groceryCounts.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grocery List'),
        actions: [
          IconButton(
            tooltip: 'Share List',
            icon: const Icon(Icons.share),
            onPressed: () {
              final text =
                  items.map((e) => '• ${e.key} (x${e.value})').join('\n');
              Share.share('Grocery List\n\n$text', subject: 'Grocery List');
            },
          ),
          IconButton(
            tooltip: 'Clear List',
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              app.clearGroceryList();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Grocery list cleared')),
              );
            },
          ),
        ],
      ),
      body: items.isEmpty
          ? const Center(
              child: Text('No items yet. Generate from Meal Planner.'))
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemBuilder: (_, i) {
                final e = items[i];
                final checked = app.groceryChecked.contains(e.key);
                return CheckboxListTile(
                  value: checked,
                  onChanged: (_) => app.toggleGroceryChecked(e.key),
                  title: Text(
                    e.key,
                    style: TextStyle(
                      decoration: checked ? TextDecoration.lineThrough : null,
                      color: checked ? Colors.white60 : Colors.white,
                    ),
                  ),
                  subtitle: Text('Count: ${e.value}'),
                );
              },
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemCount: items.length,
            ),
    );
  }
}
