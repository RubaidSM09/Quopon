import 'package:get/get.dart';

class Select {
  final String selectTitle;
  final List<String> selectOptions;

  Select({
    required this.selectTitle,
    required this.selectOptions,
  });
}

class Cart {
  final String? image;
  final String title;
  final List<Select>? selectedAddons;
  final double price;
  final int quantity;

  Cart({
    this.image,
    required this.title,
    this.selectedAddons,
    required this.price,
    this.quantity = 1,
  });
}

class CartController extends GetxController {
  var cart = <Cart>[].obs;

  @override
  void onInit() {
    super.onInit();

    cart.value = [
      Cart(
        image: 'assets/images/Cart/Italian Panini.png',
        title: 'Italian Panini',
        selectedAddons: [
          Select(
            selectTitle: 'Cheese',
            selectOptions: ['Cheddar'],
          ),
          Select(
            selectTitle: 'Spreads',
            selectOptions: ['Mayo', 'Ranch', 'Chipotle'],
          ),
        ],
        price: 9.00,
      ),
      Cart(
        image: 'assets/images/Cart/Italian Panini.png',
        title: 'Italian Panini',
        selectedAddons: [
          Select(
            selectTitle: 'Cheese',
            selectOptions: ['Cheddar'],
          ),
          Select(
            selectTitle: 'Spreads',
            selectOptions: ['Mayo', 'Ranch', 'Chipotle'],
          ),
        ],
        price: 9.00,
      ),
      Cart(
        image: 'assets/images/Cart/Italian Panini.png',
        title: 'Italian Panini',
        selectedAddons: [
          Select(
            selectTitle: 'Cheese',
            selectOptions: ['Cheddar'],
          ),
          Select(
            selectTitle: 'Spreads',
            selectOptions: ['Mayo', 'Ranch', 'Chipotle'],
          ),
        ],
        price: 9.00,
      ),
      Cart(
        image: 'assets/images/Cart/Italian Panini.png',
        title: 'Italian Panini',
        selectedAddons: [
          Select(
            selectTitle: 'Select Cheese',
            selectOptions: ['Cheddar'],
          ),
          Select(
            selectTitle: 'Select Spreads',
            selectOptions: ['Mayo', 'Ranch', 'Chipotle'],
          ),
        ],
        price: 9.00,
      ),
    ];
  }
}
