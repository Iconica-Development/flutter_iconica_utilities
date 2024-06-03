# Iconica utilities

Small package that can be included in your app to access regularly used utility functions.

## Installation

To add this package in your project, add to your pubspec.yaml:

```yaml
iconica_utilities:
  git:
    url: git@bitbucket.org:iconicadevs/iconica_utilities.git
    ref: 0.0.4
```

## Features

[Bidirectional sorter](#Bidirectional%20Sorter)

[Highlighted text](#Highlighted%20text)

## Bidirectional Sorter

Generic implementation of sorter for lists. It can sort primitive and complex objects, Both in descendig and ascending order. Can also sort multiple fields at the same time for complex objects using sortMulti

### Usage

```dart
import 'package:iconica_utilities/iconica_utilities.dart';

// Creating list of Strings
List<String> listToSort = [];
for (int i = 0; i < 10; i++) {
    listToSort.add("name$i");
}

// Calling the sort method
sort<String>(SortDirection.descending, listToSort);

print(listToSort)

// Returns
[name9, name8, name7, name6, name5, name4, name3, name2, name1, name0]
```

## Highlighted text

Generic implementation of the highlighted text widget, can be used as an extension of the regular text widget. Highlighted style, mainstyle and highlight matchers can be given as parameters. A fourth parameter is provided to add a tap recognizer called "onTapRecognizer" which takes a VoidCallback.

### Usage

```dart
import 'package:iconica_utilities/iconica_utilities.dart';

// This creates a widget showing the text, This is a test, where the word test is colored red.
List<String> highlightMatchers = ['test']
Text('This is a test').highlight(highlightMatchers,
  highlighStyle: TextStyle(
    color: toTestColor,
    ),
  ),
```

```dart
import 'package:iconica_utilities/iconica_utilities.dart';

// This creates a widget showing the text, "This is a red, and this blue", where the word red is colored red and the word is colored blue.
Text('This is a red, and this blue').multiHighlight([
    HighlightModel(
      ['red'],
      highlightStyle: TextStyle(
        color: Colors.red,
      ),
    ),
    HighlightModel(
      ['blue'],
      highlightStyle: TextStyle(
        color: Colors.blue,
      ),
    ),         
  ],
),
```

## Contributing

When contributing create a branch and send in a pull-request. This request will then be reviewed and merged.

Make sure, everthing listed down below is done.

- Sensable tests are written for each future (with atleast 90% coverage)
- All other tests stil work
- [dartfmt](https://dart.dev/tools/dart-format) is ran
- [dartdoc](https://dart.dev/tools/dartdoc) is written (using ///)
- Version number is increased in the [pubspec.yaml](./pubspec.yaml)
- [changelog](./CHANGELOG.md) is updated
- Your feature is added to the [README.md](./README.md) (See examples of already added features for template)

NOTE: To check your coverage, run the tests with the `--coverage` option. Then run `genhtml -o coverage coverage/lcov.info`

If all of the above are done, a PR can be created.
