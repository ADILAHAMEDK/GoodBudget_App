import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db_function/transaction/transaction_db.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';
import 'package:money_manager/widgets/home_screen.dart';

class ScreenSearchPage extends StatefulWidget {
  const ScreenSearchPage({Key? key}) : super(key: key);

  @override
  _ScreenSearchPageState createState() => _ScreenSearchPageState();
}

class _ScreenSearchPageState extends State<ScreenSearchPage> {
  String searchQuery = '';
   DateTime? selectedDate;
 // search 
List<TransactionModel> filterTransactions(String searchQuery, DateTime? selectedDate) {
  return TransactionDB.instance.transactionListNotifier.value.where((transaction) {
    final bool matchesSearchQuery = transaction.purpose.toLowerCase().contains(searchQuery.toLowerCase()) ||
        transaction.amount.toStringAsFixed(2).contains(searchQuery.toLowerCase());
    final bool matchesSelectedDate = selectedDate == null || transaction.date == selectedDate;
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
          backgroundColor:  const Color.fromARGB(255, 12, 46, 62),
          leading: IconButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
          }, icon:const Icon(Icons.arrow_back)),
          title: const Text('Search Transactions'),
        ),
        body: Padding(
          padding:const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.text,
                decoration:const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search',
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    updateFilteredTransactions();
                  });
                },
              ),
                      const SizedBox(height: 10),
              // ElevatedButton(
              //   onPressed: () async {
              //     final selectedDateTemp = await showDatePicker(
              //       context: context,
              //       initialDate: selectedDate ?? DateTime.now(),
              //       firstDate: DateTime(2020),
              //       lastDate: DateTime.now(),
              //     );
              //     if (selectedDateTemp == null) {
              //       return;
              //     } else {
              //       setState(() {
              //         selectedDate = selectedDateTemp;
              //         updateFilteredTransactions();
              //       });
              //     }
              //   },
              //   child: Text(selectedDate == null ? 'Select Date' : 'Selected Date: ${DateFormat.yMd().format(selectedDate!)}'),
              // ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: selectedDate == null ? 'Select date' : DateFormat.yMd().format(selectedDate!),
                 suffixIcon: Icon(Icons.date_range),
                ),
                readOnly: true,
                onTap: () async{
                   final selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime.now(),
                  );
                  if (selectedDateTemp == null) {
                    return;
                  } else {
                    setState(() {
                      selectedDate = selectedDateTemp;
                      updateFilteredTransactions();
                    });
                  }
                
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredTransactions.length,
                  itemBuilder: (context, index) {
                    final transaction = filteredTransactions[index];
                    return Dismissible(
                      key: Key(transaction.id!),
                      onDismissed: (direction) {
                        deleteTransactions(transaction.id!);
                      },
                      background: Container(
                        color: Colors.grey,
                        alignment: Alignment.centerRight,
                        child:const Icon(Icons.delete,color: Colors.white,),
                      ),
                      child: Card(
                        child: ListTile(
                          title: Text('Amount: ${transaction.amount.toStringAsFixed(2)}', style:const TextStyle(
                            fontSize: 16,fontWeight: FontWeight.w500,
                            color:Color.fromARGB(255, 12, 46, 62)),),
                           subtitle:Text(DateFormat.yMd().format(transaction.date),style:const TextStyle(
                            fontSize: 15,fontWeight: FontWeight.w500,color:  Colors.red),),
                           trailing:Text(transaction.purpose,style:const TextStyle(
                            fontSize: 18,fontWeight: FontWeight.w500,
                            color:  Color.fromARGB(255, 12, 46, 62)),),               
                          // Add more details as needed
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void deleteTransactions(String s) {}
}