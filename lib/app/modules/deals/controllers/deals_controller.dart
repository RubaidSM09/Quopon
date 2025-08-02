import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/restaurant_card.dart';

class DealsController extends GetxController {
  // Define an observable list of restaurant cards as RxList
  var restaurantCards = <Widget>[].obs;  // Use .obs to make it reactive

  // List of booleans indicating if a card is premium (blurred) or not
  var isPremiumList = <bool>[true, false, false, true, true, false, true, false].obs;

  @override
  void onInit() {
    super.onInit();
    //generateCardsFromPremiumList();
  }

  // Method to generate restaurant cards based on the isPremiumList
  void generateCardsFromPremiumList() {
    restaurantCards.clear();

    // Iterate through the isPremiumList and generate corresponding cards
    for (int i = 0; i < isPremiumList.length; i++) {
      bool isPremium = isPremiumList[i];

      // restaurantCards.add(
      //   isPremium
      //       ? RestaurantCardBlur(
      //     restaurantImg: 'assets/images/deals/Pizza.jpg',
      //     restaurantName: 'Pizzeria Bella Italia',
      //     deliveryFee: 'US\$0 Delivery Free',
      //     distance: '12 mi',
      //     rating: '4.2',
      //     reviewCount: '500+',
      //     deliveryTime: '10 min',
      //   )
      //       : RestaurantCard(
      //     discountTxt: '20% Discount',
      //     restaurantImg: 'assets/images/deals/Pizza.jpg',
      //     restaurantName: 'Pizzeria Bella Italia',
      //     deliveryFee: 'US\$0 Delivery Free',
      //     distance: '12 mi',
      //     rating: '4.2',
      //     reviewCount: '500+',
      //     deliveryTime: '10 min',
      //   ),
      // );
    }
    update(); // Notify listeners that the data has changed
  }

  // Method to change the premium status of a card (optional)
  void togglePremiumStatus(int index) {
    isPremiumList[index] = !isPremiumList[index];
    generateCardsFromPremiumList(); // Re-generate the cards based on updated list
  }
}
