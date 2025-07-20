import 'package:get/get.dart';

class CountryController extends GetxController {
  // Reactive variable for selected country
  RxString selectedCountry = 'United States of America'.obs;

  // List of countries to display in the dropdown
  final List<String> countries = [
    'United States of America',
    'Canada',
    'Germany',
    'Japan',
    'Bangladesh',
  ];

  // Method to update the selected country
  void setSelectedCountry(String country) {
    selectedCountry.value = country;
  }
}
