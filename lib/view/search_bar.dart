import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  // TODO: Search History
  static const historyLength = 5;

  // ignore: prefer_final_fields
  List<String> _searchHistory = [
    'cbd oil',
    'cbd vape',
    'thc free',
  ];

  List<String> filteredSearchHistory = [];

  String selectedTerm = '';

  List<String> filterSearchTerms({
    required String filter,
  }) {
    if (filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      /*   putSearchTermFirst(term);
      return;
    }
*/
      _searchHistory.add(term);
      if (_searchHistory.length > historyLength) {
        _searchHistory.removeRange(0, _searchHistory.length - historyLength);
      }

      filteredSearchHistory = filterSearchTerms(filter: selectedTerm);
    }

    /*void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => term);
    filteredSearchHistory = filterSearchTerms(filter: null);
  }*/

    /* void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }*/

    FloatingSearchBarController controller = FloatingSearchBarController();

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      filteredSearchHistory = filterSearchTerms(filter: selectedTerm);
    }

    @override
    void dispose() {
      // TODO: implement dispose
      controller.dispose();
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      hint: 'Search..',
      openAxisAlignment: 0.0,
      width: 500,
      height: 48,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 5),
      elevation: 5.0,
      onQueryChanged: (query) {},
      transition: CircularFloatingSearchBarTransition(),
      transitionCurve: Curves.easeInOut,
      transitionDuration: const Duration(milliseconds: 500),
      builder: (context, transition) {
        return ClipRRect(
            child: Material(
          color: Colors.white,
        ));
      },
    );
  }
}
