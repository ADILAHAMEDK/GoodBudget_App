import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../db_function/transaction/transaction_db.dart';
import '../../models/category/category_model.dart';
import '../../models/transaction/transaction_model.dart';

class Chart extends StatefulWidget {
  final bool checkboxStatus;
  final DateTime currentDate;

  const Chart({
    required this.checkboxStatus,
    required this.currentDate,
  });

  @override
  State<StatefulWidget> createState() => ChartState();
}

class ChartState extends State<Chart> {
  int touchedIndex = 0;
  String _selectedValue = 'Day';
  List<TransactionModel> transactions = [];

  @override
  void initState() {
    super.initState();
    transactions = TransactionDB.instance.transactions!;
    updateTransactions(_selectedValue);
  }

  void updateTransactions(String selectedValue) {
    print("Selected Value: $selectedValue");
    setState(() {
      _selectedValue = selectedValue;
      // Define startDate and endDate for the week filter
      DateTime now = DateTime.now();
      DateTime startDate = DateTime.now(); // Default to the current date
      DateTime endDate = DateTime.now(); // Default to the current date

      // Calculate the start and end dates based on the current date
      if (_selectedValue == 'Week') {
        int todayWeekday = startDate.weekday;
        startDate = startDate.subtract(Duration(
            days: todayWeekday - 1)); // Start of the current week (Sunday)
        endDate = startDate.add(Duration(
            days: 7 - todayWeekday)); // End of the current week (Saturday)
      }

      // Filter transactions based on the selected value (Day, Week, Month)
      if (_selectedValue == 'Day') {
        transactions = TransactionDB.instance.getTransactionsByDay();
      } else if (_selectedValue == 'Week') {
        transactions =
            TransactionDB.instance.getTransactionsByWeek(startDate, endDate);
      } else if (_selectedValue == 'Month') {
        transactions = TransactionDB.instance.getTransactionsByMonth();
      }
      print("Number of Transactions: ${transactions.length}");
    });
  }

  List<PieChartSectionData> showingSections() {
    double totalIncome = 0;
    double totalExpenses = 0;

    // Filter transactions based on the selected time frame (_selectedValue)
    final now = DateTime.now();
    final startOfWeek = DateTime(now.year, now.month, now.day - now.weekday);
    final endOfWeek =
        DateTime(now.year, now.month, now.day + (6 - now.weekday));
    final filteredTransactions = transactions.where((transaction) {
      if (_selectedValue == 'Day') {
        final today = DateTime(now.year, now.month, now.day);
        return transaction.date.isAtSameMomentAs(today);
      } else if (_selectedValue == 'Week') {
        return transaction.date.isAfter(startOfWeek) &&
            transaction.date.isBefore(endOfWeek);
      } else if (_selectedValue == 'Month') {
        final startOfMonth = DateTime(now.year, now.month, 1);
        final endOfMonth = DateTime(now.year, now.month + 1, 0);
        return transaction.date.isAfter(startOfMonth) &&
            transaction.date.isBefore(endOfMonth);
      }
      return false;
    }).toList();

    for (var transaction in filteredTransactions) {
      if (transaction.type == CategoryType.income) {
        totalIncome += transaction.amount;
      } else if (transaction.type == CategoryType.expense) {
        totalExpenses += transaction.amount;
      }
    }

    double completedPercentage =
        totalIncome / (totalIncome + totalExpenses) * 100;
    double remainingPercentage = 100 - completedPercentage;

    return generateChartData(completedPercentage, remainingPercentage);
  }

  List<PieChartSectionData> generateChartData(double value1, double value2) {
    final List<Color> colors = [Colors.green[900]!, Colors.red[400]!];
    final List<double> values = [value1, value2];

    return List.generate(2, (i) {
      final isTouched = i == touchedIndex; // Make sure to define touchedIndex
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;

      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        color: colors[i],
        value: values[i],
        title: '${values[i].toStringAsFixed(1)}%', // Limit to one decimal place
        radius: 150,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
          shadows: shadows,
        ),
      );
    });
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 12, 46, 62),
        title: const Center(child: Text('Charts')),
      ),
      body: Center(
        child: Card(
          color: Colors.white10,
          //const Color.fromARGB(255, 35, 71, 73),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton<String>(
                    elevation: 10,
                    underline: Container(
                      height: 2,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    dropdownColor: Colors.white,
                    // Color.fromARGB(255, 0, 0, 0),
                    focusColor: Colors.white,
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsetsDirectional.all(3),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    value: _selectedValue,
                    style: const TextStyle(color: Colors.white),
                    items: <String>['Day', 'Week', 'Month']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            // Color.fromARGB(255, 255, 255, 255),
                            fontFamily: AutofillHints.username,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          updateTransactions(newValue);
                        });
                      }
                    },
                  ),
                ],
              ),
              AspectRatio(
                aspectRatio: 1.0,
                child: PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      },
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 0,
                    centerSpaceRadius: 0,
                    sections: showingSections(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
