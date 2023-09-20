import 'package:flutter/material.dart';
import '../homeScreen/home_screen.dart';
import 'package:money_manager/db_function/category/category_db.dart';

import 'expense_list.dart';
import 'income_list.dart';

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