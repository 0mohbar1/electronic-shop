class ApiShopping {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  Rating? rating;
  bool? isFavorite;

  ApiShopping(
      {this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.image,
        this.rating,
        this.isFavorite=false});

  ApiShopping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price']?.toDouble();
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating =
    json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    isFavorite = json['isFavorite'] ?? false;

  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'].toDouble();
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }
}
