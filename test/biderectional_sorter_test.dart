// SPDX-FileCopyrightText: 2022 Iconica
//
// SPDX-License-Identifier: BSD-3-Clause

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_iconica_utilities/iconica_utilities.dart';

import 'test_object.dart';

void main() {
  group("Bidirectional sorter", () {
    group("Primitives", () {
      test("Sort in descending order", () {
        List<String> names = [];
        for (int i = 0; i < 10; i++) {
          names.add("name$i");
        }

        sort<String>(SortDirection.descending, names);

        expect(names.first, equals("name9"));
        expect(names.last, equals("name0"));
      });

      test("Sort in ascending order", () {
        List<String> names = [];
        for (int i = 9; i >= 0; i--) {
          names.add("name$i");
        }

        sort<String>(SortDirection.ascending, names);

        expect(names.first, equals("name0"));
        expect(names.last, equals("name9"));
      });

      test("Sort with given comparable in descending order", () {
        List<String> names = [];
        for (int i = 0; i < 10; i++) {
          names.add("name$i");
        }

        sort<String>(SortDirection.descending, names, (name) => name);

        expect(names.first, equals("name9"));
        expect(names.last, equals("name0"));
      });

      test("Sort with given comparable in ascending order", () {
        List<String> names = [];
        for (int i = 9; i >= 0; i--) {
          names.add("name$i");
        }

        sort<String>(SortDirection.ascending, names, (name) => name);

        expect(names.first, equals("name0"));
        expect(names.last, equals("name9"));
      });

      test("Sort in descending order given an empty list should not throw", () {
        List<String> names = [];

        sort<String>(SortDirection.descending, names);

        expect(names, equals(names));
      });

      test("Sort in ascending order given an empty list should not throw", () {
        List<String> names = [];

        sort<String>(SortDirection.ascending, names);

        expect(names, equals(names));
      });

      test(
          "Sort with given comparable in descending order given an empty list should not throw",
          () {
        List<String> names = [];

        sort<String>(SortDirection.descending, names);

        expect(names, equals(names));
      });

      test(
          "Sort with given comparable in ascending order given an empty list should throw",
          () {
        List<String> names = [];

        sort<String>(SortDirection.ascending, names);

        expect(names, equals(names));
      });
    });
    group("Complex", () {
      test("Sort with given comparable in descending order", () {
        List<TestObject> objects = [];
        for (int i = 0; i < 10; i++) {
          objects.add(TestObject(name: "name", id: i));
        }

        sort<TestObject>(
            SortDirection.descending, objects, (object) => object.id);

        expect("${objects.first.name}${objects.first.id}", equals("name9"));
        expect("${objects.last.name}${objects.last.id}", equals("name0"));
      });

      test("Sort with given comparable in ascending order", () {
        List<TestObject> objects = [];
        for (int i = 9; i >= 0; i--) {
          objects.add(TestObject(name: "name", id: i));
        }

        sort<TestObject>(
            SortDirection.ascending, objects, (object) => object.id);

        expect("${objects.first.name}${objects.first.id}", equals("name0"));
        expect("${objects.last.name}${objects.last.id}", equals("name9"));
      });

      test(
          "Sort with given comparable in descending order given an empty list should not throw",
          () {
        List<TestObject> objects = [];

        sort<TestObject>(SortDirection.descending, objects);

        expect(objects, equals(objects));
      });

      test(
          "Sort with given comparable in ascending order given an empty list should throw",
          () {
        List<TestObject> objects = [];

        sort<TestObject>(SortDirection.ascending, objects);

        expect(objects, equals(objects));
      });

      test("Sort without comparable in descending order should throw", () {
        List<TestObject> objects = [];
        for (int i = 0; i < 10; i++) {
          objects.add(TestObject(name: "name", id: i));
        }

        expect(() => sort<TestObject>(SortDirection.descending, objects),
            throwsAssertionError);
      });

      test("Sort without comparable in ascending order should throw", () {
        List<TestObject> objects = [];
        for (int i = 9; i >= 0; i--) {
          objects.add(TestObject(name: "name", id: i));
        }

        expect(() => sort<TestObject>(SortDirection.ascending, objects),
            throwsAssertionError);
      });
    });
  });
}
