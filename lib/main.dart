import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/order_event.dart';
import 'repository/mock_repository.dart';
import 'bloc/order_bloc.dart';
import 'ui/screens/home_screen.dart';

void main() {
  final repository = MockRepository();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final MockRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => OrderBloc(repository: repository)..add(LoadRestaurantsEvent()),
        child: MaterialApp(
          title: 'Food Order Workflow',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
