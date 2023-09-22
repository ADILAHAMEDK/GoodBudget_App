import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db_function/category/category_db.dart';
import 'package:money_manager/db_function/transaction/transaction_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';
import 'package:money_manager/view/editTransactionScreen/editTransactionScreen.dart';
import 'package:money_manager/view/transaction/history_page.dart';
import 'package:money_manager/view/transaction/search_page.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  double calculateIncome(List<TransactionModel> transactions) {
    double totalIncome = 0;
    for (var transaction in transactions) {
      if (transaction.type == CategoryType.income) {
        totalIncome += transaction.amount;
      }
    }
    return totalIncome;
  }

  double calculateExpenses(List<TransactionModel> transactions) {
    double totalExpenses = 0;
    for (var transaction in transactions) {
      if (transaction.type == CategoryType.expense) {
        totalExpenses += transaction.amount;
      }
    }
    return totalExpenses;
  }

  double calculateTotalBalance(double totalIncome, double totalExpenses) {
    return totalIncome - totalExpenses;
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        32.0,
                      ),
                      color: Colors.white70,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: 64,
                        height: 50,
                        child: Image.asset(
                          "assets/images/money manager logo.png",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 19,
                  ),
                  const Text(
                    'Money Manager',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(255, 12, 46, 62),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ScreenSearchPage()));
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 32,
                      )),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionListNotifier,
              builder: (BuildContext ctx, List<TransactionModel> newList,
                  Widget? _) {
                double totalIncome = calculateIncome(newList);
                double totalExpenses = calculateExpenses(newList);
                double totalBalance =
                    calculateTotalBalance(totalIncome, totalExpenses);
                return Column(children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: const EdgeInsets.all(
                      12.0,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 12, 46, 62),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 8.0,
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Total Balance',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.yellow,
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            ' ${totalBalance.toStringAsFixed(2)}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text(
                                          'Income',
                                          style: TextStyle(
                                            color: Colors.yellow,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                    child: Text(
                                      ' ${totalIncome.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text(
                                          'Expence',
                                          style: TextStyle(
                                            color: Colors.yellow,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(30, 0, 0, 0),
                                    child: Text(
                                      ' ${totalExpenses.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'Recent Transection',
                            style: TextStyle(
                              color: Color.fromARGB(255, 12, 46, 62),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HistoryPage(
                                allTransactions: newList,
                              ),
                            )),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 12, 46, 62),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(10),
                      itemBuilder: (ctx, index) {
                        if (index < 4) {
                          final _value = newList[index];

                          // final _value = newList[index];
                          return Slidable(
                            key: Key(_value.id!),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (ctx) {
                                    TransactionDB.instance
                                        .deleteTransaction(_value.id!);
                                  },
                                  icon: Icons.delete,
                                  label: 'Delete',
                                ),
                                SlidableAction(
                                  onPressed: (ctx) {
                                    //on tap i need to go to anothe page to edit

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditPage(
                                            transaction: _value,
                                          ),
                                        ));
                                  },
                                  icon: Icons.edit,
                                  label: 'Edit',
                                ),
                              ],
                            ),
                            child: Card(
                              elevation: 0,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 20,
                                  child: _value.type == CategoryType.income
                                      ? const Icon(
                                          Icons.arrow_circle_up,
                                          color: Colors.green,
                                          size: 30,
                                        )
                                      : const Icon(
                                          Icons.arrow_circle_down_outlined,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                  backgroundColor: _value.type ==
                                          CategoryType.income
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : const Color.fromARGB(
                                          255, 255, 255, 255),
                                  // if()if

                                  // radius: 50,
                                  // child:Icon(Icons.arrow_outward_rounded),
                                  // // Text(parseDate(_value.date),
                                  // // textAlign: TextAlign.center,
                                  // // ),
                                  // backgroundColor: _value.type == CategoryType.income? Colors.green : Colors.red,
                                ),
                                title: Text(
                                  'RS: ${_value.amount}',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 12, 46, 62),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                subtitle: Text(
                                  parseDate(_value.date),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                //Text(_value.purpose),
                                //Text(_value.category.name),

                                trailing: Column(
                                  children: [
                                    Text(
                                      _value.purpose,
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 12, 46, 62),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      _value.category.name,
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 12, 46, 62),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                      },
                      separatorBuilder: (ctx, index) {
                        return //const SizedBox(height: 10, );
                            const Divider(
                          thickness: 1,
                        );
                      },
                      itemCount: newList.length <= 4 ? newList.length : 5,
                    ),
                  ),
                ]);
              },
            ),
          ),
        ),
      ]),
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
    //'${date.day}\n${date.month}';
  }
}
