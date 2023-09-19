import 'package:flutter/material.dart';
import 'package:money_manager/screens/category/categoryy/popup.dart';
import 'package:money_manager/screens/category/categoryy/screen_category.dart';
import 'package:money_manager/screens/category/setting/screen_setting.dart';
import 'package:money_manager/screens/category/transaction/add_transaction.dart';
import 'package:money_manager/screens/category/transaction/screen_transaction.dart';
import 'package:money_manager/screens/charts/screen_chart.dart';
import 'package:money_manager/widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = [
    const ScreenTransaction(),
    const ScreenCategory(),
    Chart(checkboxStatus: true, currentDate: DateTime.now()),
    const ScreenSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title:const Text('Money Manager'),
      //   centerTitle: true,
      // ),
      bottomNavigationBar: const BottomNavBar(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('add transaction');
            Navigator.of(context).pushNamed(AddTransactionPage.routeName);
          } else {
            print('add category');

            showCategoryAddPopup(context);

            //  final _sample = CategoryModel(
            //    id: DateTime.now().millisecondsSinceEpoch.toString(),
            //    name: 'travel',
            //    type: CategoryType.expense,
            //    );
            //  CategoryDB().insertCategory(_sample);
          }
        },
        backgroundColor: const Color.fromARGB(255, 12, 46, 62),
        child: const Icon(Icons.add),
      ),
    );
  }
}
