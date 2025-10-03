import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_app/bloc/order_event.dart';
import 'package:food_app/bloc/order_state.dart' hide OrderBloc, LoadRestaurantsEvent;
import 'package:mocktail/mocktail.dart';
import 'package:food_app/repository/mock_repository.dart';
import 'package:food_app/bloc/order_bloc.dart';
import 'package:food_app/models/restaurant.dart';
import 'package:food_app/models/menu_item.dart';

class MockRepo extends Mock implements MockRepository {}

void main() {
  late MockRepo repo;
  late OrderBloc bloc;

  setUp(() {
    repo = MockRepo();
    bloc = OrderBloc(repository: repo);
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state is OrderInitial', () {
    expect(bloc.state, isA<OrderInitial>());
  });

  blocTest<OrderBloc, OrderState>(
    'loads restaurants successfully',
    build: () {
      when(() => repo.fetchRestaurants()).thenAnswer((_) async => [
        Restaurant(id: 'r1', name: 'Test', subtitle: '', rating: 4.0, assetPath: '', menu: [
          MenuItem(id: 'm1', name: 'Item', description: '', price: 10, assetPath: '')
        ], category: '',)
      ]);
      return bloc;
    },
    act: (b) => b.add(LoadRestaurantsEvent()),
    expect: () => [isA<RestaurantsLoading>(), isA<RestaurantsLoaded>()],
  );
}
