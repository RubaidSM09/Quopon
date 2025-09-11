class Cart {
  int? id;
  String? userEmail;
  int? user;
  String? deliveryType;
  List<Items>? items;
  PriceSummary? priceSummary;

  Cart(
      {this.id,
        this.userEmail,
        this.user,
        this.deliveryType,
        this.items,
        this.priceSummary});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userEmail = json['user_email'];
    user = json['user'];
    deliveryType = json['delivery_type'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    priceSummary = json['price_summary'] != null
        ? new PriceSummary.fromJson(json['price_summary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_email'] = this.userEmail;
    data['user'] = this.user;
    data['delivery_type'] = this.deliveryType;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.priceSummary != null) {
      data['price_summary'] = this.priceSummary!.toJson();
    }
    return data;
  }
}

class Items {
  int? id;
  MenuItem? menuItem;
  int? quantity;
  List<SelectedOptions>? selectedOptions;
  String? addToCartPrice;

  Items(
      {this.id,
        this.menuItem,
        this.quantity,
        this.selectedOptions,
        this.addToCartPrice});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuItem = json['menu_item'] != null
        ? new MenuItem.fromJson(json['menu_item'])
        : null;
    quantity = json['quantity'];
    if (json['selected_options'] != null) {
      selectedOptions = <SelectedOptions>[];
      json['selected_options'].forEach((v) {
        selectedOptions!.add(new SelectedOptions.fromJson(v));
      });
    }
    addToCartPrice = json['add_to_cart_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.menuItem != null) {
      data['menu_item'] = this.menuItem!.toJson();
    }
    data['quantity'] = this.quantity;
    if (this.selectedOptions != null) {
      data['selected_options'] =
          this.selectedOptions!.map((v) => v.toJson()).toList();
    }
    data['add_to_cart_price'] = this.addToCartPrice;
    return data;
  }
}

class MenuItem {
  int? id;
  String? name;
  String? description;
  String? price;
  int? calories;
  String? imageUrl;
  bool? addedToCart;
  double? totalPrice;
  List<OptionTitle>? optionTitle;

  MenuItem(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.calories,
        this.imageUrl,
        this.addedToCart,
        this.totalPrice,
        this.optionTitle});

  MenuItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    calories = json['calories'];
    imageUrl = json['image_url'];
    addedToCart = json['added_to_cart'];
    totalPrice = json['total_price'];
    if (json['option_title'] != null) {
      optionTitle = <OptionTitle>[];
      json['option_title'].forEach((v) {
        optionTitle!.add(new OptionTitle.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['calories'] = this.calories;
    data['image_url'] = this.imageUrl;
    data['added_to_cart'] = this.addedToCart;
    data['total_price'] = this.totalPrice;
    if (this.optionTitle != null) {
      data['option_title'] = this.optionTitle!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OptionTitle {
  int? id;
  String? title;
  bool? isRequired;
  List<Options>? options;

  OptionTitle({this.id, this.title, this.isRequired, this.options});

  OptionTitle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    isRequired = json['is_required'];
    if (json['options'] != null) {
      options = <Options>[];
      json['options'].forEach((v) {
        options!.add(new Options.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['is_required'] = this.isRequired;
    if (this.options != null) {
      data['options'] = this.options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Options {
  int? id;
  String? name;
  String? price;
  bool? isSelected;

  Options({this.id, this.name, this.price, this.isSelected});

  Options.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    isSelected = json['is_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['is_selected'] = this.isSelected;
    return data;
  }
}

class SelectedOptions {
  int? id;
  String? name;
  String? price;
  bool? isSelected;

  SelectedOptions({this.id, this.name, this.price, this.isSelected});

  SelectedOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    isSelected = json['is_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['is_selected'] = this.isSelected;
    return data;
  }
}

class PriceSummary {
  double? subTotalPrice;
  double? deliveryCharges;
  double? inTotalPrice;

  PriceSummary({this.subTotalPrice, this.deliveryCharges, this.inTotalPrice});

  PriceSummary.fromJson(Map<String, dynamic> json) {
    subTotalPrice = json['sub_total_price'];
    deliveryCharges = json['delivery_charges'];
    inTotalPrice = json['in_total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_total_price'] = this.subTotalPrice;
    data['delivery_charges'] = this.deliveryCharges;
    data['in_total_price'] = this.inTotalPrice;
    return data;
  }
}
