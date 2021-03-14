import 'package:radius_v3/widgets/menu/popularcard.widget.dart';

double totalPrice = 0;
String resturanteRef = "";

class CartContent {
  final int id;
  final String title;
  final String imageURL;
  final int contentPrice;
  int contentQuantity;

  CartContent(this.id, this.title, this.imageURL, this.contentPrice,
      this.contentQuantity);
  Map toJson() => {
        'id': id,
        'title': title,
        'imageURL': imageURL,
        'contentPrice': contentPrice,
        'contentQuantity': contentQuantity,
      };
}

refreshTotalPrice() {
  totalPrice = 0;

  for (var _content in cartContents) {
    totalPrice += _content.contentPrice * _content.contentQuantity;
  }
}

List<CartContent> cartContents = [];
