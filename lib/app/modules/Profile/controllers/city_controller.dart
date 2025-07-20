import 'package:get/get.dart';

class CityController extends GetxController {
  // Reactive variable for selected country
  RxString selectedCity = 'Washington'.obs;

  // List of countries to display in the dropdown
  final List<String> cities = [
    'Washington',
    'Texas',
    'Los Angels',
    'California',
    'New York',
  ];

  // Method to update the selected country
  void setSelectedCountry(String country) {
    selectedCity.value = country;
  }
}
