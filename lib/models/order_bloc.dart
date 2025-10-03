import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

abstract class OrderEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PlaceOrderEvent extends OrderEvent {}

class ApplyPromoEvent extends OrderEvent {
  final String code;
  ApplyPromoEvent(this.code);

  @override
  List<Object?> get props => [code];
}

class OrderState extends Equatable {
  final bool isPlacing;
  final bool orderSuccess;
  final String? orderError;

  const OrderState({
    this.isPlacing = false,
    this.orderSuccess = false,
    this.orderError,
  });

  OrderState copyWith({
    bool? isPlacing,
    bool? orderSuccess,
    String? orderError,
  }) {
    return OrderState(
      isPlacing: isPlacing ?? this.isPlacing,
      orderSuccess: orderSuccess ?? this.orderSuccess,
      orderError: orderError,
    );
  }

  @override
  List<Object?> get props => [isPlacing, orderSuccess, orderError];
}

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(const OrderState()) {
    on<PlaceOrderEvent>(_onPlaceOrder);
    on<ApplyPromoEvent>(_onApplyPromo);
  }

  Future<void> _onPlaceOrder(
      PlaceOrderEvent event, Emitter<OrderState> emit) async {
    emit(state.copyWith(isPlacing: true, orderError: null, orderSuccess: false));

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(
        isPlacing: false,
        orderSuccess: true,
        orderError: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isPlacing: false,
        orderSuccess: false,
        orderError: 'Something went wrong. Please try again.',
      ));
    }
  }

  void _onApplyPromo(ApplyPromoEvent event, Emitter<OrderState> emit) {
    print("Promo Applied: ${event.code}");
  }
}
