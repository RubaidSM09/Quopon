// lib/app/modules/Profile/controllers/country_city_controller.dart
import 'package:get/get.dart';

class CountryCityController extends GetxController {
  // Country → cities map (extend as needed)
  final Map<String, List<String>> countryCities = {
    'United States of America': ['Washington', 'Texas', 'Los Angeles', 'California', 'New York'],
    'Canada': ['Toronto', 'Vancouver', 'Montreal', 'Calgary', 'Ottawa'],
    'Germany': ['Berlin', 'Munich', 'Hamburg', 'Cologne', 'Frankfurt'],
    'Japan': ['Tokyo', 'Osaka', 'Kyoto', 'Yokohama', 'Sapporo'],
    'Bangladesh': ['Dhaka', 'Chittagong', 'Sylhet', 'Khulna', 'Rajshahi'],
    'United Kingdom': ['London', 'Manchester', 'Birmingham', 'Leeds', 'Glasgow'],
  };

  // Selected values
  final RxString selectedCountry = 'United States of America'.obs;
  final RxString selectedCity = 'Washington'.obs;

  // The currently available cities for the selectedCountry
  final RxList<String> cities = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _refreshCities();
  }

  void setCountry(String country) {
    selectedCountry.value = country;
    _refreshCities();
    // reset city to first available city for that country
    if (cities.isNotEmpty) {
      selectedCity.value = cities.first;
    } else {
      selectedCity.value = '';
    }
  }

  void setCity(String city) => selectedCity.value = city;

  void hydrateFromProfile({required String country, required String city}) {
    if (countryCities.containsKey(country)) {
      selectedCountry.value = country;
      _refreshCities();
      if (cities.contains(city)) {
        selectedCity.value = city;
      } else if (cities.isNotEmpty) {
        selectedCity.value = cities.first;
      } else {
        selectedCity.value = '';
      }
    } else {
      // Unknown country from backend — keep it but show no cities
      selectedCountry.value = country;
      cities.assignAll([]);
      selectedCity.value = city;
    }
  }

  void _refreshCities() {
    cities.assignAll(countryCities[selectedCountry.value] ?? []);
  }
}
