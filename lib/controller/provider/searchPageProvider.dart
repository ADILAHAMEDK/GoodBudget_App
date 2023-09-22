
import 'package:flutter/material.dart';

class SearchPageProvider extends ChangeNotifier {
  String searchQuery = '';
  DateTime? selectedDate;
  

  void setSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
  }

  void setSelectedDate(DateTime? date) {
    selectedDate = date;
    notifyListeners();
  }
}
