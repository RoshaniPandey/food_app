import 'package:equatable/equatable.dart';
import '../models/restaurant.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadRestaurantsEvent extends OrderEvent {}

class SelectRestaurantEvent extends OrderEvent {
  final Restaurant restaurant;
  SelectRestaurantEvent(this.restaurant);

  @override
  List<Object?> get props => [restaurant];
}

class AddItemEvent extends OrderEvent {
  final String itemId;
  AddItemEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class RemoveItemEvent extends OrderEvent {
  final String itemId;
  RemoveItemEvent(this.itemId);

  @override
  List<Object?> get props => [itemId];
}

class ApplyPromoEvent extends OrderEvent {
  final String code;
  ApplyPromoEvent(this.code);

  @override
  List<Object?> get props => [code];
}

class PlaceOrderEvent extends OrderEvent {}

class ClearCartEvent extends OrderEvent {}
