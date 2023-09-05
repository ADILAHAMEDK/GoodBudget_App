import 'package:flutter/material.dart';
import 'package:money_manager/screens/category/categoryy/expense_list.dart';
import 'package:money_manager/screens/category/categoryy/income_list.dart';
import 'package:money_manager/db_function/category/category_db.dart';
import 'package:money_manager/screens/category/transaction/screen_transaction.dart';
import 'package:money_manager/widgets/bottom_navigation_bar.dart';
import 'package:money_manager/widgets/home_screen.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 46, 62),
        title: const Text('Select Phone Number'),
        centerTitle: true, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs:const[
              Tab(text: 'Income'),
              Tab(text: 'Expence'),
            ]),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:const [
                  IncomeList(),
                  ExpenseList(),     
              ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}