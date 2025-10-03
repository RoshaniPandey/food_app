import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/mock_repository.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final MockRepository repository;

  OrderBloc({required this.repository}) : super(OrderInitial()) {
    on<LoadRestaurantsEvent>(_onLoadRestaurants);
    on<SelectRestaurantEvent>(_onSelectRestaurant);
    on<AddItemEvent>(_onAddItem);
    on<RemoveItemEvent>(_onRemoveItem);
    on<ApplyPromoEvent>(_onApplyPromo);
    on<PlaceOrderEvent>(_onPlaceOrder);
    on<ClearCartEvent>(_onClearCart);
  }

  Future<void> _onLoadRestaurants(
      LoadRestaurantsEvent e, Emitter<OrderState> emit) async {
    emit(RestaurantsLoading());
    try {
      final list = await repository.fetchRestaurants();
      emit(RestaurantsLoaded(restaurants: list, cart: {}));
    } catch (err) {
      emit(RestaurantsLoadFailure(message: err.toString()));
    }
  }

  void _onSelectRestaurant(
      SelectRestaurantEvent e, Emitter<OrderState> emit) {
    final current = state;
    if (current is RestaurantsLoaded) {
      emit(current.copyWith(selectedRestaurant: e.restaurant));
    }
  }

  void _onAddItem(AddItemEvent e, Emitter<OrderState> emit) {
    final current = state;
    if (current is RestaurantsLoaded) {
      final cart = Map<String, int>.from(current.cart);
      cart.update(e.itemId, (v) => v + 1, ifAbsent: () => 1);
      emit(current.copyWith(cart: cart));
    }
  }

  void _onRemoveItem(RemoveItemEvent e, Emitter<OrderState> emit) {
    final current = state;
    if (current is RestaurantsLoaded) {
      final cart = Map<String, int>.from(current.cart);
      if (!cart.containsKey(e.itemId)) return;
      final qty = cart[e.itemId]!;
      if (qty <= 1) {
        cart.remove(e.itemId);
      } else {
        cart[e.itemId] = qty - 1;
      }
      emit(current.copyWith(cart: cart));
    }
  }

  void _onApplyPromo(ApplyPromoEvent e, Emitter<OrderState> emit) {
    final current = state;
    if (current is RestaurantsLoaded) {
      double discount = 0.0;
      if (e.code.toLowerCase() == "foodie10") {
        discount = 0.10;
      } else if (e.code.toLowerCase() == "free50") {
        discount = 50.0;
      }
      emit(current.copyWith(promoCode: e.code, discount: discount));
    }
  }

  Future<void> _onPlaceOrder(
      PlaceOrderEvent e, Emitter<OrderState> emit) async {
    final current = state;
    if (current is! RestaurantsLoaded) return;
    if (current.cart.isEmpty) {
      emit(current.copyWith(orderError: 'Cart is empty'));
      return;
    }
    emit(current.copyWith(isPlacing: true, orderError: null));
    try {
      await repository.placeOrder(
          current.selectedRestaurant!.id, current.cart);
      emit(current.copyWith(isPlacing: false, orderSuccess: true, cart: {}));
    } catch (err) {
      emit(current.copyWith(isPlacing: false, orderError: err.toString()));
    }
  }

  void _onClearCart(ClearCartEvent e, Emitter<OrderState> emit) {
    final current = state;
    if (current is RestaurantsLoaded) {
      emit(current.copyWith(cart: {}));
    }
  }
}
