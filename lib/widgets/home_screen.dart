import 'package:flutter/material.dart';
import 'package:money_manager/category/popup.dart';
import 'package:money_manager/category/screen_category.dart';
import 'package:money_manager/db_function/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/setting/screen_setting.dart';
import 'package:money_manager/transaction/screen_transaction.dart';
import 'package:money_manager/widgets/bottom_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  static ValueNotifier<int>selectedIndexNotifier = ValueNotifier(0);

  final _pages = [
   const ScreenTransaction(),
   const ScreenCategory(),
   const ScreenSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text('Money Manager'),
        centerTitle: true,
      ),
      bottomNavigationBar:const BottomNavBar(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
       builder: (BuildContext context, int updatedIndex, _) {
        return _pages[updatedIndex];
        
      },),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        if(selectedIndexNotifier.value == 0) {
          print('add transaction');
        }else{
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
      child: Icon(Icons.add),
      ),
    );
  }
}