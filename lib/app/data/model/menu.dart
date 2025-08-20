class Menu {
  int? id;
  String? name;
  List<Items>? items;

  Menu({this.id, this.name, this.items});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  String? name;
  String? description;
  String? price;
  int? calories;
  String? imageUrl;
  List<OptionTitle>? optionTitle;

  Items(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.calories,
        this.imageUrl,
        this.optionTitle});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    calories = json['calories'];
    imageUrl = json['image_url'];
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
