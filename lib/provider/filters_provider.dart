import 'package:flutter_riverpod/flutter_riverpod.dart';
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
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
        (ref) => FiltersNotifier());
