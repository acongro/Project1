class Recipe {
  final String id;
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final Set<String> tags;
  final int minutes;
  final int servings;
  final String difficulty;
  const Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.tags,
    required this.minutes,
    required this.servings,
    required this.difficulty,
  });
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'imageUrl': imageUrl,
        'ingredients': ingredients,
        'steps': steps,
        'tags': tags.toList(),
        'minutes': minutes,
        'servings': servings,
        'difficulty': difficulty,
      };
  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json['id'],
        title: json['title'],
        imageUrl: json['imageUrl'],
        ingredients: List<String>.from(json['ingredients']),
        steps: List<String>.from(json['steps']),
        tags: Set<String>.from(json['tags']),
        minutes: json['minutes'],
        servings: json['servings'],
        difficulty: json['difficulty'],
      );
}
