import 'package:equatable/equatable.dart';
import '../models/restaurant.dart';

abstract class OrderState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OrderInitial extends OrderState {}

class RestaurantsLoading extends OrderState {}

class RestaurantsLoadFailure extends OrderState {
  final String message;
  RestaurantsLoadFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class RestaurantsLoaded extends OrderState {
  final List<Restaurant> restaurants;
  final Map<String, int> cart;
  final String? promoCode;
  final double discount;
  final Restaurant? selectedRestaurant;
  final bool isPlacing;
  final bool orderSuccess;
  final String? orderError;

  RestaurantsLoaded({
    required this.restaurants,
    required this.cart,
    this.promoCode,
    this.discount = 0.0,
    this.selectedRestaurant,
    this.isPlacing = false,
    this.orderSuccess = false,
    this.orderError,
  });

  RestaurantsLoaded copyWith({
    List<Restaurant>? restaurants,
    Map<String, int>? cart,
    String? promoCode,
    double? discount,
    Restaurant? selectedRestaurant,
    bool? isPlacing,
    bool? orderSuccess,
    String? orderError,
  }) {
    return RestaurantsLoaded(
      restaurants: restaurants ?? this.restaurants,
      cart: cart ?? this.cart,
      promoCode: promoCode ?? this.promoCode,
      discount: discount ?? this.discount,
      selectedRestaurant: selectedRestaurant ?? this.selectedRestaurant,
      isPlacing: isPlacing ?? this.isPlacing,
      orderSuccess: orderSuccess ?? this.orderSuccess,
      orderError: orderError ?? this.orderError,
    );
  }

  @override
  List<Object?> get props => [
    restaurants,
    cart,
    promoCode,
    discount,
    selectedRestaurant,
    isPlacing,
    orderSuccess,
    orderError
  ];
}
