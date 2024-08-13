class ApiShopping {
  List<Product>? product;

  ApiShopping({this.product});

  ApiShopping.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? id;
  String? name;
  String? image;
  String? desc;
  int? price;
  String? color;
  int? discount;
  int? departmentId;
  String? createdAt;
  String? updatedAt;
bool? isFavorite;
  Product(
      {this.id,
        this.name,
        this.image,
        this.desc,
        this.price,
        this.color,
        this.discount,
        this.departmentId,
        this.createdAt,
        this.updatedAt,
  this.isFavorite=false});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    desc = json['desc'];
    price = json['price'];
    color = json['color'];
    discount = json['discount'];
    departmentId = json['department_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  isFavorite = json['isFavorite'] ?? false;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['desc'] = this.desc;
    data['price'] = this.price;
    data['color'] = this.color;
    data['discount'] = this.discount;
    data['department_id'] = this.departmentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}