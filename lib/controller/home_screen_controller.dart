import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  int index = 0;
  //forNavigatePages
  changeIndex(int index) {
    this.index = index;
    update();
  }
  //forSearching
  searchData() {
    var searchQuery = ''.obs; // Observable to store the search query

    void setSearchQuery(String query) {
      searchQuery.value = query; // Update the search query
    }
  }
}
