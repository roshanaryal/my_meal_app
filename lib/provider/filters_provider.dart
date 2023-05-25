import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mealsapp/provider/meals_provider.dart';
import 'package:mealsapp/screens/filter_screen.dart';

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
      : super({
          Filters.guttenFree: false,
          Filters.lactoseFree: false,
          Filters.vegeterian: false,
          Filters.vegan: false,
        });

  void setFilter(Filters filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filters, bool> choosenFilter) {
    state = choosenFilter;
  }

  bool getfilter(Filters filter) {
    return state[filter]!;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
        (ref) => FiltersNotifier());

final filterMealProvider = Provider((ref) {
  final meal = ref.watch(mealsProvider);
  final activeFilter = ref.watch(filtersProvider);

  return meal.where((meal) {
    if (!meal.isGlutenFree && activeFilter[Filters.guttenFree]!) {
      return false;
    }
    if (!meal.isLactoseFree && activeFilter[Filters.lactoseFree]!) {
      return false;
    }
    if (!meal.isVegetarian && activeFilter[Filters.vegeterian]!) {
      return false;
    }
    if (!meal.isVegan && activeFilter[Filters.vegan]!) {
      return false;
    }

    return true;
  }).toList();
});
