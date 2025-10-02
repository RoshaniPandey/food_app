import 'package:equatable/equatable.dart';
import 'menu_item.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String subtitle;
  final String category;
  final String assetPath;
  final List<MenuItem> menu;
  final double rating;
  final bool isVeg;
  final double avgPrice;
  final List<MenuItem> popularItems;

  const Restaurant({
    required this.id,
    required this.name,
    required this.subtitle,
    required this.category,
    required this.assetPath,
    required this.menu,
    this.rating = 0.0,
    this.isVeg = true,
    this.avgPrice = 0.0,
    this.popularItems = const [],
  });

  @override
  List<Object?> get props => [
    id,
    name,
    subtitle,
    category,
    assetPath,
    menu,
    rating,
    isVeg,
    avgPrice,
    popularItems,
  ];
}
