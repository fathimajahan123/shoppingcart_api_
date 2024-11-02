import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart_api_/controller/cart_screen_controller.dart';
import 'package:shoppingcart_api_/controller/home_screen_controller.dart';
import 'package:shoppingcart_api_/controller/product_detail_screen_controller.dart';
import 'package:shoppingcart_api_/model/cart_model.dart';
import 'package:shoppingcart_api_/view/get_started_screen/get_started_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); //hive step 1
  Hive.registerAdapter(CartModelAdapter());
  var box = await Hive.openBox<CartModel>("cartBox"); // hive step 2

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenController()),
        ChangeNotifierProvider(
            create: (context) => ProductDetailScreenController()),
        ChangeNotifierProvider(create: (context) => CartScreenController())
      ],
      child: MaterialApp(
        home: GetStartedScreen(),
      ),
    );
  }
}
