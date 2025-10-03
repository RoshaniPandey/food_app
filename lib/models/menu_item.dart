import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String assetPath;
  final bool? isSpicy;
  final double? discountPrice;

  const MenuItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.assetPath,
    this.isSpicy,
    this.discountPrice,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    assetPath,
    isSpicy,
    discountPrice,
  ];
}
