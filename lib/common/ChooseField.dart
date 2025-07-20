import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/modules/Profile/controllers/city_controller.dart';
import '../app/modules/Profile/controllers/country_controller.dart';

class ChooseCountryField extends GetView<CountryController> {
  const ChooseCountryField({super.key});

  @override
  Widget build(BuildContext context) {
    final CountryController countryController = Get.put(CountryController());

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Country",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            SizedBox(),
          ],
        ),
        SizedBox(height: 8,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            return DropdownButtonFormField<String>(
              value: countryController.selectedCountry.value,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              items: countryController.countries.map((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Update the selected country using GetX's controller
                if (newValue != null) {
                  countryController.setSelectedCountry(newValue);
                }
              },
            );
          }),
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}

class ChooseCityField extends GetView<CityController> {
  const ChooseCityField({super.key});

  @override
  Widget build(BuildContext context) {
    final CityController cityController = Get.put(CityController());

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "City",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
            SizedBox(),
          ],
        ),
        SizedBox(height: 8,),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Obx(() {
            return DropdownButtonFormField<String>(
              value: cityController.selectedCity.value,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              items: cityController.cities.map((String country) {
                return DropdownMenuItem<String>(
                  value: country,
                  child: Text(country),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Update the selected country using GetX's controller
                if (newValue != null) {
                  cityController.setSelectedCountry(newValue);
                }
              },
            );
          }),
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}