import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(onPressed: (){
        //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ScreenSettings()));
        // }, icon: const Icon(Icons.arrow_back)),
        backgroundColor: const Color.fromARGB(255, 12, 46, 62),
        title: const Text("About"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text(
              '''Expense Tracking: Money manager apps allow users to record and categorize their expenses. This helps individuals understand where their money is going and identify areas where they can cut costs.

Budgeting: Many money manager apps offer budgeting features that help users set spending limits for various categories, such as groceries, entertainment, and utilities. The app can then track spending against these budgets and provide alerts when limits are exceeded.

Income Tracking: Users can input their sources of income, such as salary, freelance earnings, or rental income, into the app. This helps individuals see their overall financial picture.

Savings Goals: Money manager apps often include tools for setting and tracking savings goals. Users can establish specific targets, such as saving for a vacation or an emergency fund, and monitor their progress.

Debt Management: Some apps include features for tracking and managing debt, such as credit card balances, loans, and mortgages. They may provide strategies for paying off debt more efficiently.

Investment Tracking: For those with investment portfolios, money manager apps can provide a way to track the performance of investments, view asset allocation, and analyze investment returns.

Bill Payment Reminders: Money manager apps may have bill reminder features to help users avoid missed payments and late fees.

Bank Account Integration: Many apps allow users to link their bank and credit card accounts, making it easier to

Developed by Adil ahamed
'''),
        ),
      ),
    );
  }
}
