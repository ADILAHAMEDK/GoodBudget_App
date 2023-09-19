import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';
import 'package:money_manager/widgets/home_screen.dart';

//clear from db - reset
Future<void> resetDB(
  BuildContext context,
) async {
  // ignore: use_build_context_synchronously
  bool confirmReset = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor:  const Color.fromARGB(255, 12, 46, 62),
        title: const Text(
          "Confirm Reset",
          style: TextStyle(color: Colors.white),
        ),
        content: const Text(
          "Are you sure you want to reset",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            child:const Text(
              "Cancel",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child:const Text(
              "Reset",
              style: TextStyle(color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      );
    },
  );

  if (confirmReset == true) {
    const TRANSACTION_DB_NAME ='transaction_db';
    const CATEGORY_DB_NAME = 'category-database';
    final videoDb = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    videoDb.clear();
    final favoriteDb = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME );
    favoriteDb.clear();
    final chartDB = await Hive.openBox<CategoryType>('statistics');
    chartDB.clear();

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
 ));
}
}