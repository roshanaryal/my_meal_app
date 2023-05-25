import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/model/meal.dart';

class FavouriteMealProvider extends StateNotifier<List<Meal>> {
  FavouriteMealProvider() : super([]);

  bool toggleMealFavouriteStatus(Meal meal) {
    final isFavouriteMeal = state.contains(meal);
    if (isFavouriteMeal) {
      state = state.where((m) => meal.id != m.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }

  bool isInFavouriteList(Meal meal) {
    return state.contains(meal);
  }
}

final favouriteMealProvider =
    StateNotifierProvider<FavouriteMealProvider, List<Meal>>((ref) {
  return FavouriteMealProvider();
});
