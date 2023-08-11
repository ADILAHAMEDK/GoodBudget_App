import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_manager/db_function/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/widgets/home_screen.dart';

Future<void> main() async{
  //final obj1 = CategoryDB();
 // final obj2 = CategoryDB();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)){
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  
  if(!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)){
    Hive.registerAdapter(CategoryModelAdapter());
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Money Manager',
      home: HomeScreen(),
    );
  }
}

