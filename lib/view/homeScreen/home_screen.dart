import 'package:flutter/material.dart';
import 'package:money_manager/helpers/colors.dart';
import '../addTransactionScreen/add_transaction.dart';
import '../../widgets/bottomNavigationBar/bottom_navigation_bar.dart';
import '../category/popup.dart';
import '../category/screen_category.dart';
import '../chart/screen_chart.dart';
import '../settings/screen_setting.dart';
import '../transaction/screen_transaction.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final pages = [
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
            return pages[updatedIndex];
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
        backgroundColor: AppColors.allBlue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
