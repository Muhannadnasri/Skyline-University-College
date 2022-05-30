import 'package:skyline_university/widgets/constant.dart';

import '../Home/FAQ/faq.dart';

class ProductModel {
  int id;
  String name;
  // Function suggestion;

  double price;
  String image;
  double rating;
  int review;
  int sale;
  String location;

  ProductModel(
      {this.id,
      this.name,
      // this.suggestion,
      this.price,
      this.image,
      this.rating,
      this.review,
      this.sale,
      this.location});
}

List<ProductModel> productData = [
  ProductModel(
      id: 1,
      name: 'My Attendance',
      image: GLOBAL_URL + '/assets/images/apps/ecommerce/product/28.jpg',
      rating: 5,
      review: 129,
      sale: 310,
      location: 'attendance'
      // location: 'Brooklyn'
      ),
  ProductModel(
    id: 2,
    name: 'Assessment Marks Courses',
    image: GLOBAL_URL + '/assets/images/apps/ecommerce/product/43.jpg',
    rating: 5,
    review: 16,
    sale: 37,
    // location: 'Brooklyn'
  ),
  ProductModel(
    id: 3,
    name: 'Final Term Results',
    image: GLOBAL_URL + '/assets/images/apps/ecommerce/product/44.jpg',
    rating: 5,
    review: 2,
    sale: 3,
    // location: 'Brooklyn'
  ),
  ProductModel(
    id: 4,
    name: 'Pay Online',
    price: 120,
    image: GLOBAL_URL + '/assets/images/apps/ecommerce/product/19.jpg',
    rating: 5,
    review: 4,
    sale: 6,
    // location: 'Brooklyn'
  ),
  ProductModel(
    id: 5,
    name: 'Letter Request',
    price: 62,
    image: GLOBAL_URL + '/assets/images/apps/ecommerce/product/46.jpg',
    rating: 5,
    review: 42,
    sale: 69,
    // location: 'Brooklyn'
  ),
  ProductModel(
    id: 6,
    name: 'FAQ?',
    price: 751,
    image: GLOBAL_URL + '/assets/images/apps/ecommerce/product/30.jpg',
    rating: 5,
    review: 14,
    sale: 17,
    // suggestion: () => FAQ(),
    // location: ,
  ),
  ProductModel(
    id: 20,
    name: 'Gallery',
    price: 333,
    image: GLOBAL_URL + '/assets/images/apps/ecommerce/product/12.jpg',
    rating: 5,
    review: 13,
    sale: 33,
    // location: 'Brooklyn'
  )
];
