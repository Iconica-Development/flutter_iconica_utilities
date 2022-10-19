import 'package:flutter_iconica_utilities/src/biderectional_sorter/enum.dart';

typedef SortFieldGetter<T> = Comparable Function(T sortable);

class SortInstruction<T> {
  final SortFieldGetter<T> getSortValue;
  final SortDirection sortDirection;

  SortInstruction(this.getSortValue, this.sortDirection);
}

class BidirectionalSorter<T> {
  final List<SortInstruction<T>> sortInstructions;
  BidirectionalSorter({
    required this.sortInstructions,
  });
  void sort(List<T> toSort) {
    toSort.sort((a, b) {
      for (final sortInstruction in sortInstructions) {
        var callback = sortInstruction.getSortValue;
        final aSortValue = callback(a);
        final bSortValue = callback(b);
        if (aSortValue != bSortValue) {
          if (sortInstruction.sortDirection == SortDirection.ascending) {
            return aSortValue.compareTo(bSortValue);
          } else {
            return bSortValue.compareTo(aSortValue);
          }
        }
      }
      return 0;
    });
  }
}
