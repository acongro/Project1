import 'recipe.dart';

final sampleRecipes = <Recipe>[
  Recipe(
    id: 'r1',
    title: 'Veggie Stir-Fry',
    imageUrl:
        'https://cdn.loveandlemons.com/wp-content/uploads/2025/02/stir-fry-recipe.jpg',
    ingredients: [
      '2 cups mixed veggies',
      '1 tbsp soy sauce (GF if needed)',
      '1 tsp sesame oil',
      '1 clove garlic',
    ],
    steps: [
      'Heat pan with oil.',
      'Add garlic and veggies; cook 5–7 min.',
      'Stir in soy sauce; serve hot.',
    ],
    tags: {'vegetarian', 'vegan', 'gluten-free'},
    minutes: 15,
    servings: 2,
    difficulty: 'Easy',
  ),
  Recipe(
    id: 'r2',
    title: 'Chicken & Rice',
    imageUrl:
        'https://www.simplyrecipes.com/thmb/RuMZjwQ6sH5wORCNWhwz6zRWZxY=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Simply-Recipes-One-Pot-Chicken-Rice-LEAD-5-a12e6b1f477a43f493104e2a9d756199.jpg',
    ingredients: [
      '1 cup rice',
      '2 cups water',
      '8 oz chicken breast',
      'Salt & pepper',
    ],
    steps: [
      'Cook rice in water (10–12 min).',
      'Season chicken and pan-sear 4–5 min/side.',
      'Slice and plate with rice.',
    ],
    tags: {'gluten-free'},
    minutes: 25,
    servings: 2,
    difficulty: 'Easy',
  ),
  Recipe(
    id: 'r3',
    title: 'Gluten-Free Pasta Marinara',
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtnOG46muVoXZpy7Uh7F3I1GpDZTo3rPVmLA&s',
    ingredients: [
      '8 oz GF pasta',
      '1 cup marinara',
      '1 tbsp olive oil',
      'Basil & salt',
    ],
    steps: [
      'Boil pasta as directed.',
      'Warm marinara with oil.',
      'Combine, season, garnish with basil.',
    ],
    tags: {'vegetarian', 'gluten-free'},
    minutes: 20,
    servings: 2,
    difficulty: 'Easy',
  ),
  Recipe(
    id: 'r4',
    title: 'Chicken Parmesan',
    imageUrl:
        'https://majasrecipes.com/wp-content/uploads/2024/12/chicken-parm-2.jpg',
    ingredients: [
      '2 chicken cutlets (8–10 oz total)',
      '1/2 cup breadcrumbs',
      '1/4 cup grated Parmesan',
      '1 egg (beaten)',
      '1 cup marinara sauce',
      '1/2 cup shredded mozzarella',
      'Salt & pepper',
      '1 tbsp olive oil',
    ],
    steps: [
      'Season chicken with salt & pepper.',
      'Dip in egg, then coat with breadcrumbs mixed with Parmesan.',
      'Pan-fry in olive oil 3–4 min/side until golden.',
      'Top with marinara and mozzarella; cover until cheese melts.',
      'Serve with pasta or salad.',
    ],
    tags: {'contains-gluten'},
    minutes: 30,
    servings: 2,
    difficulty: 'Medium',
  ),
  Recipe(
    id: 'r5',
    title: 'Steak & Mashed Potatoes',
    imageUrl:
        'https://rachaelsgoodeats.com/wp-content/uploads/2023/06/IMG_3163-scaled.jpg',
    ingredients: [
      '2 small steaks (ribeye or sirloin, ~10 oz total)',
      '2 medium potatoes',
      '2 tbsp butter',
      '1/4 cup milk (or splash)',
      'Salt & pepper',
      '1 tbsp oil',
      'Optional: garlic & herbs',
    ],
    steps: [
      'Boil peeled potato chunks until tender; drain.',
      'Mash with butter, milk, salt & pepper.',
      'Pat steaks dry, season well.',
      'Sear in hot oiled pan 2–4 min/side to preferred doneness; rest 5 min.',
      'Plate steak with mashed potatoes; add herbs if desired.',
    ],
    tags: {'gluten-free'},
    minutes: 30,
    servings: 2,
    difficulty: 'Easy',
  ),
];
