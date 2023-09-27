import 'package:flutter/material.dart';

class HomeScreenProvider extends ChangeNotifier {
  int _index = 0;

  // Getter for index
  int get index => _index;

  // Setter for index
  set index(int newIndex) {
    _index = newIndex;
    notifyListeners();
  }

  // // For searching
  // String _searchQuery = '';

  // // Getter for searchQuery
  // String get searchQuery => _searchQuery;

  // // Setter for searchQuery
  // set searchQuery(String newQuery) {
  //   _searchQuery = newQuery;
  //   notifyListeners();
  // }

  // // Method to update the search query
  // void updateSearchQuery(String query) {
  //   searchQuery = query;
  // }
}
