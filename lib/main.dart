import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/controller/provider/addTransactionProvider.dart';
import 'package:money_manager/controller/provider/editPageProvider.dart';
import 'package:money_manager/controller/provider/searchPageProvider.dart';
import 'package:money_manager/db_function/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';
import 'package:money_manager/view/addTransactionScreen/add_transaction.dart';
import 'package:money_manager/view/homeScreen/home_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //final obj1= CategoryDB();
  //final obj2 = CategoryDB();

  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }
  await Hive.openBox<TransactionModel>('transactionsBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddTransactionProvider()),
        ChangeNotifierProvider(create: (context) => SearchPageProvider()),
        ChangeNotifierProvider(create: (context) => EditPageProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Money Manager',
        home: HomeScreen(),
        routes: {
          AddTransactionPage.routeName: (ctx) => const AddTransactionPage(),
        },
      ),
    );
  }
}
