import 'package:get/get.dart';

class Deal {
  final String dealImg;
  final String dealTitle;
  final String dealDescription;
  final String dealValidity;

  Deal({
    required this.dealImg,
    required this.dealTitle,
    required this.dealDescription,
    required this.dealValidity,
  });
}

class Item {
  final String title;
  final double price;
  final double calory;
  final String description;
  final String? image;

  Item({
    required this.title,
    required this.price,
    required this.calory,
    required this.description,
    this.image
  });
}

class VendorProfileController extends GetxController {
  var activeDeals = <Deal>[].obs;
  var menu = <String>[].obs;
  var items = <Item>[].obs;

  @override
  void onInit() {
    super.onInit();

    activeDeals.value = [
      Deal(
        dealImg: 'assets/images/VendorProfile/Coffee.jpg',
        dealTitle: 'Buy 1 Get 1 Free on Any Espresso Beverage',
        dealDescription: 'Buy any espresso drink and get another free, available after 2 PM.',
        dealValidity: 'June 30, 2025',
      ),
      Deal(
        dealImg: 'assets/images/VendorProfile/Tea.png',
        dealTitle: 'Cool Down with 20% Off Cold Brew',
        dealDescription: 'Enjoy 20% off all cold drinks, including Vanilla Sweet Cream & Nitro Brew.',
        dealValidity: 'July 10, 2025',
      ),
      Deal(
        dealImg: 'assets/images/VendorProfile/Tart.png',
        dealTitle: 'Morning Combo: Coffee + Croissant',
        dealDescription: 'Start your day right with a tall brewed coffee and butter croissant.',
        dealValidity: 'June 25, 2025',
      ),
    ];

    menu.value = [
      "Hot Coffee",
      "Cold Coffee",
      "Hot Tea",
      "Cold Tea",
      "Refreshers"
    ];

    items.value = [
      Item(
        title: 'Blonde Roast - Sunsera',
        price: 3.15,
        calory: 5,
        description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text.',
        image: 'assets/images/VendorProfile/Shake.png',
      ),
      Item(
        title: 'Blonde Roast - Sunsera',
        price: 3.15,
        calory: 5,
        description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text.',
        image: 'assets/images/VendorProfile/Shake.png',
      ),
      Item(
        title: 'Blonde Roast - Sunsera',
        price: 3.15,
        calory: 5,
        description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text.',
        image: 'assets/images/VendorProfile/Shake.png',
      ),
      Item(
        title: 'Blonde Roast - Sunsera',
        price: 3.15,
        calory: 5,
        description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text.',
        image: 'assets/images/VendorProfile/Shake.png',
      ),
    ];
  }
}
