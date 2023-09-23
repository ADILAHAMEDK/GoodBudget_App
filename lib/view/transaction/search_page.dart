import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db_function/transaction/transaction_db.dart';
import 'package:money_manager/helpers/colors.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';
import 'package:provider/provider.dart';
import '../../controller/provider/searchPageProvider.dart';
import '../homeScreen/home_screen.dart';

class ScreenSearchPage extends StatefulWidget {
  const ScreenSearchPage({Key? key}) : super(key: key);

  @override
  _ScreenSearchPageState createState() => _ScreenSearchPageState();
}

class _ScreenSearchPageState extends State<ScreenSearchPage> {
  String searchQuery = '';
  ////////?????????????????????
  DateTime? selectedDate;
  // search
  List<TransactionModel> filterTransactions(
      String searchQuery, DateTime? selectedDate) {
    return TransactionDB.instance.transactionListNotifier.value
        .where((transaction) {
      final bool matchesSearchQuery = transaction.purpose
              .toLowerCase()
              .contains(searchQuery.toLowerCase()) ||
          transaction.amount
              .toStringAsFixed(2)
              .contains(searchQuery.toLowerCase());
      final bool matchesSelectedDate =
          selectedDate == null || transaction.date == selectedDate;
      return matchesSearchQuery && matchesSelectedDate;
    }).toList();
  }

  List<TransactionModel> filteredTransactions = [];

  void updateFilteredTransactions() {
    setState(() {
      filteredTransactions = filterTransactions(searchQuery, selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.allBlue,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              icon: const Icon(Icons.arrow_back)),
          title: const Text('Search Transactions'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: ChangeNotifierProvider(
            create: (context) => SearchPageProvider(),
            child: Column(
              children: [
                Consumer<SearchPageProvider>(builder: (context, Provider, _) {
                  return TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Search',
                    ),
                    onChanged: (value) {
                      Provider.setSearchQuery(value); // Update search query
                      updateFilteredTransactions();

                      // setState(() {
                      //   searchQuery = value;
                      //   updateFilteredTransactions();
                      // });
                    },
                  );
                }),
                const SizedBox(height: 10),
                Consumer<SearchPageProvider>(builder: (context, Provider, _) {
                  return TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: Provider.selectedDate == null
                          ? 'Select date'
                          : DateFormat.yMd().format(Provider.selectedDate!),
                      suffixIcon: const Icon(Icons.date_range),
                    ),
                    readOnly: true,
                    onTap: () async {
                      final selectedDateTemp = await showDatePicker(
                        context: context,
                        initialDate: Provider.selectedDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (selectedDateTemp == null) {
                        return;
                      } else {
                        Provider.setSelectedDate(
                            selectedDateTemp); // Update selected date
                        updateFilteredTransactions();
                        // setState(() {
                        //   selectedDate = selectedDateTemp;
                        //   updateFilteredTransactions();
                        // });
                      }
                    },
                  );
                }),
                const SizedBox(height: 10),
                Expanded(
                  child: Consumer<SearchPageProvider>(
                      builder: (context, Provider, _) {
                    final filteredTransactions = filterTransactions(
                        Provider.searchQuery, Provider.selectedDate);

                    return ListView.builder(
                      itemCount: filteredTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = filteredTransactions[index];
                        return Dismissible(
                          key: Key(transaction.id!),
                          onDismissed: (direction) {
                            deleteTransactions(transaction.id!);
                          },
                          background: Container(
                            color:AppColors.allGray ,
                            alignment: Alignment.centerRight,
                            child: const Icon(
                              Icons.delete,
                              color: AppColors.allRed,
                            ),
                          ),
                          child: Card(
                            child: ListTile(
                              title: Text(
                                'Amount: ${transaction.amount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.allBlue),
                              ),
                              subtitle: Text(
                                DateFormat.yMd().format(transaction.date),
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.allRed),
                              ),
                              trailing: Text(
                                transaction.purpose,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.allBlue),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTransactions(String s) {}
}
