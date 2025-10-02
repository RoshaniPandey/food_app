import 'dart:math';
import '../models/restaurant.dart';
import '../models/menu_item.dart';

class MockRepository {
  final Random _rand = Random();

  Future<List<Restaurant>> fetchRestaurants() async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (_rand.nextInt(10) < 2) {
      throw Exception('Failed to load restaurants (simulated network error)');
    }
    return _fakeRestaurants;
  }

  Future<void> placeOrder(String restaurantId, Map<String, int> items) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (_rand.nextInt(10) < 2) {
      throw Exception('Payment gateway error (simulated)');
    }
    return;
  }
}

final _menu1 = [
  MenuItem(id: 'm1', name: 'Paneer Butter Masala', description: 'Creamy tomato gravy with soft paneer', price: 179.0, assetPath: 'assets/paneer.png'),
  MenuItem(id: 'm2', name: 'Masala Dosa', description: 'Crispy dosa with sambar and chutney', price: 99.0, assetPath: 'assets/dosa.png'),
  MenuItem(id: 'm3', name: 'Gulab Jamun', description: 'Dessert soaked in sugar syrup', price: 59.0, assetPath: 'assets/gulab.png'),
];

final _menu2 = [
  MenuItem(id: 'm4', name: 'Margherita Pizza', description: 'Classic cheese & tomato', price: 249.0, assetPath: 'assets/img_1.png'),
  MenuItem(id: 'm5', name: 'Farmhouse Pizza', description: 'Veg loaded with toppings', price: 329.0, assetPath: 'assets/img_2.png'),
  MenuItem(id: 'm6', name: 'Chocolate Brownie', description: 'Warm brownie', price: 99.0, assetPath: 'assets/img_3.png'),
  MenuItem(id: 'm10', name: 'Cheese Burst Pizza', description: 'Cheesy delight', price: 349.0, assetPath: 'assets/img_8.png'),
  MenuItem(id: 'm11', name: 'Veggie Supreme', description: 'Loaded with veggies', price: 329.0, assetPath: 'assets/img_9.png'),
  MenuItem(id: 'm12', name: 'Garlic Bread', description: 'Crispy bread with garlic', price: 129.0, assetPath: 'assets/img_10.png'),
];


final _menu3 = [
  MenuItem(id: 'm7', name: 'Masala Dosa', description: 'Crispy dosa with potato filling', price: 99.0, assetPath: 'assets/dosa.png'),
  MenuItem(id: 'm8', name: 'Idli Sambar', description: 'Soft idlis with hot sambar', price: 79.0, assetPath: 'assets/img_6.png'),
  MenuItem(id: 'm9', name: 'Vada', description: 'Crispy medu vada', price: 69.0, assetPath: 'assets/img_7.png'),
  MenuItem(id: 'm19', name: 'Chicken Tandoori', description: 'Smoky grilled chicken', price: 299.0, assetPath: 'assets/img_12.png'),
  MenuItem(id: 'm20', name: 'Paneer Tikka', description: 'Grilled paneer cubes', price: 199.0, assetPath: 'assets/img_13.png'),
  MenuItem(id: 'm21', name: 'Seekh Kebab', description: 'Spicy minced kebabs', price: 249.0, assetPath: 'assets/img_14.png'),
];

final _menu4 = [
  MenuItem(id: 'm10', name: 'Cheese Burst Pizza', description: 'Cheesy delight', price: 349.0, assetPath: 'assets/img_8.png'),
  MenuItem(id: 'm11', name: 'Veggie Supreme', description: 'Loaded with veggies', price: 329.0, assetPath: 'assets/img_9.png'),
  MenuItem(id: 'm12', name: 'Garlic Bread', description: 'Crispy bread with garlic', price: 129.0, assetPath: 'assets/img_10.png'),
  MenuItem(id: 'm4', name: 'Margherita Pizza', description: 'Classic cheese & tomato', price: 249.0, assetPath: 'assets/img_1.png'),
  MenuItem(id: 'm5', name: 'Farmhouse Pizza', description: 'Veg loaded with toppings', price: 329.0, assetPath: 'assets/img_2.png'),
  MenuItem(id: 'm6', name: 'Chocolate Brownie', description: 'Warm brownie', price: 99.0, assetPath: 'assets/img_3.png'),
];


final _menu5 = [
  MenuItem(id: 'c01', name: 'Spicy Chicken Wings', description: 'Crispy wings with hot sauce', price: 299.0, assetPath: 'assets/img_24.png',),
  MenuItem(id: 'c02', name: 'Veggie Burger', description: 'Grilled veggie patty with fresh lettuce and tomato', price: 199.0, assetPath: 'assets/img_25.png',),
  MenuItem(id: 'c03', name: 'Cheese Fries', description: 'Golden fries loaded with melted cheese', price: 149.0, assetPath: 'assets/img_26.png',),
  MenuItem(id: 'c04', name: 'Chicken Pasta', description: 'Pasta tossed with creamy chicken sauce', price: 249.0, assetPath: 'assets/img_27.png',),
  MenuItem(id: 'c05', name: 'Chocolate Brownie', description: 'Rich chocolate brownie with ice cream', price: 129.0, assetPath: 'assets/img_3.png',),
];



final _menu6 = [
  MenuItem(id: 'm16', name: 'Green Salad', description: 'Fresh veggies & dressing', price: 149.0, assetPath: 'assets/food/salad.png'),
  MenuItem(id: 'm17', name: 'Quinoa Bowl', description: 'Healthy quinoa & veggies', price: 199.0, assetPath: 'assets/food/quinoa.png'),
  MenuItem(id: 'm18', name: 'Fruit Bowl', description: 'Seasonal fresh fruits', price: 129.0, assetPath: 'assets/food/fruits.png'),
];


final _menu7 = [
  MenuItem(id: 'm19', name: 'Chicken Tandoori', description: 'Smoky grilled chicken', price: 299.0, assetPath: 'assets/img_12.png'),
  MenuItem(id: 'm20', name: 'Paneer Tikka', description: 'Grilled paneer cubes', price: 199.0, assetPath: 'assets/img_13.png'),
  MenuItem(id: 'm21', name: 'Seekh Kebab', description: 'Spicy minced kebabs', price: 249.0, assetPath: 'assets/img_14.png'),
  MenuItem(id: 'm1', name: 'Paneer Butter Masala', description: 'Creamy tomato gravy with soft paneer', price: 179.0, assetPath: 'assets/paneer.png'),
  MenuItem(id: 'm2', name: 'Masala Dosa', description: 'Crispy dosa with sambar and chutney', price: 99.0, assetPath: 'assets/dosa.png'),
  MenuItem(id: 'm3', name: 'Gulab Jamun', description: 'Dessert soaked in sugar syrup', price: 59.0, assetPath: 'assets/gulab.png'),
];

final _menu8 = [
  MenuItem(id: 'm22', name: 'Cheese Overload Pizza', description: '4 types of cheese', price: 349.0, assetPath: 'assets/img_15.png'),
  MenuItem(id: 'm23', name: 'Mac n Cheese', description: 'Pasta with cheese sauce', price: 229.0, assetPath: 'assets/img_16.png'),
  MenuItem(id: 'm24', name: 'Cheese Nachos', description: 'Crispy nachos with cheese', price: 149.0, assetPath: 'assets/img_17.png'),
];

final _menu9 = [
  MenuItem(id: 'm25', name: 'Ice Cream Sundae', description: 'Ice cream with toppings', price: 149.0, assetPath: 'assets/img_18.png'),
  MenuItem(id: 'm26', name: 'Chocolate Cake', description: 'Rich chocolate layer cake', price: 199.0, assetPath: 'assets/img_19.png'),
  MenuItem(id: 'm27', name: 'Rasgulla', description: 'Soft Bengali sweet', price: 89.0, assetPath: 'assets/food/img_20.png'),
];

final _menu10 = [
  MenuItem(id: 'm28', name: 'Paneer Tikka Wrap', description: 'Fusion of tikka & wrap', price: 179.0, assetPath: 'assets/img_21.png'),
  MenuItem(id: 'm29', name: 'Butter Chicken Pasta', description: 'Creamy fusion pasta', price: 229.0, assetPath: 'assets/img_22.png'),
  MenuItem(id: 'm30', name: 'Desi Nachos', description: 'Indian spiced nachos', price: 149.0, assetPath: 'assets/img_23.png'),
];

final _fakeRestaurants = [
  Restaurant(
    id: 'r1',
    name: 'Saffron Spice',
    subtitle: 'North Indian • 15–25 min',
    rating: 4.5,
    assetPath: 'assets/res/rest1.png',
    category: 'Indian',
    menu: _menu1,
    avgPrice: 200,
    popularItems: [_menu1[0], _menu1[2]],
  ),
  Restaurant(
    id: 'r2',
    name: 'Oven Stories',
    subtitle: 'Pizza • 20–30 min',
    rating: 4.3,
    assetPath: 'assets/res/img.png',
    category: 'Pizza',
    menu: _menu2,
    avgPrice: 300,
    popularItems: [_menu2[0], _menu2[1], _menu2[5]],
  ),
  Restaurant(
    id: 'r3',
    name: 'Curry Leaf',
    subtitle: 'South Indian • 20–30 min',
    rating: 4.4,
    assetPath: 'assets/res/img_1.png',
    category: 'Indian',
    menu: _menu3,
    avgPrice: 180,
    popularItems: [_menu3[0], _menu3[1]],
  ),
  Restaurant(
    id: 'r4',
    name: 'Pizza Hub',
    subtitle: 'Pizza • 15–25 min',
    rating: 4.2,
    assetPath: 'assets/res/img_2.png',
    category: 'Pizza',
    menu: _menu4,
    avgPrice: 320,
    popularItems: [_menu4[0], _menu4[5]],
  ),
  Restaurant(
    id: 'r5',
    name: 'Chanies Food',
    subtitle: 'Fast Food • 15–20 min',
    rating: 4.5,
    assetPath: 'assets/res/img_3.png',
    category: 'Chinese',
    menu: _menu5,
    avgPrice: 220,
    popularItems: [_menu5[0], _menu5[2]],
  ),
  Restaurant(
    id: 'r6',
    name: 'Veggie Delight',
    subtitle: 'Healthy • 20–25 min',
    rating: 4.1,
    assetPath: 'assets/res/img_4.png',
    category: 'Chinese',
    menu: _menu6,
    avgPrice: 190,
    popularItems: [_menu6[0], _menu6[1]],
  ),
  Restaurant(
    id: 'r7',
    name: 'Tandoori Tales',
    subtitle: 'North Indian • 30–40 min',
    rating: 4.3,
    assetPath: 'assets/res/img_5.png',
    category: 'Indian',
    menu: _menu7,
    avgPrice: 280,
    popularItems: [_menu7[0], _menu7[1]],
  ),
  Restaurant(
    id: 'r8',
    name: 'Cheese Factory',
    subtitle: 'Pizza • 15–25 min',
    rating: 4.0,
    assetPath: 'assets/res/img_6.png',
    category: 'Pizza',
    menu: _menu8,
    avgPrice: 310,
    popularItems: [_menu8[0], _menu8[1]],
  ),
  Restaurant(
    id: 'r9',
    name: 'Sweet Tooth',
    subtitle: 'Desserts • 10–15 min',
    rating: 4.7,
    assetPath: 'assets/res/img_7.png',
    category: 'Desserts',
    menu: _menu9,
    avgPrice: 150,
    popularItems: [_menu9[0], _menu9[1]],
  ),
  Restaurant(
    id: 'r10',
    name: 'Spice Route',
    subtitle: 'Indian Fusion • 25–35 min',
    rating: 4.2,
    assetPath: 'assets/res/img_8.png',
    category: 'Indian',
    menu: _menu10,
    avgPrice: 250,
    popularItems: [_menu10[0], _menu10[1]],
  ),
];

