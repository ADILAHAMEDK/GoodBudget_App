import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db_function/category/category_db.dart';
import 'package:money_manager/db_function/transaction/transaction_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';
import 'package:money_manager/screens/category/transaction/edit.dart';

class HistoryPage extends StatelessWidget {
  
  const HistoryPage({super.key, required this.allTransactions});

   final List<TransactionModel> allTransactions;

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
      appBar: AppBar(
        backgroundColor:  const Color.fromARGB(255, 12, 46, 62),
        title:const Text('History'),
        centerTitle: true,
        
      ),
      body: Column(
        children: [
            Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: ValueListenableBuilder(
                valueListenable: TransactionDB.instance.transactionListNotifier,
                 builder: (BuildContext ctx , List<TransactionModel> newList, Widget? _) {
                   double totalIncome = calculateIncome(newList);
                   double totalExpenses = calculateExpenses(newList);
                   double totalBalance = calculateTotalBalance(totalIncome, totalExpenses);
                  return   Column(
                    children:[
                       Expanded(
                         child: ListView.separated(
                                    padding:const EdgeInsets.all(0),
                                    itemBuilder: (ctx,index){
                          final _value = newList[index];
                          return  Slidable(
                            key: Key(_value.id!),
                            startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                               children:[
                                SlidableAction(onPressed: (ctx){
                                  TransactionDB.instance.deleteTransaction(_value.id!);
                                },
                                icon: Icons.delete,
                                label: 'Delete',
                                ),
                                SlidableAction(onPressed: (ctx) {
                                  //on tap i need to go to anothe page to edit
                                
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> EditPage(
                                    transaction: _value,
                                    
                                  ),));
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
         backgroundColor: _value.type == CategoryType.income
         ? const Color.fromARGB(255, 255, 255, 255)
         : const Color.fromARGB(255, 255, 255, 255),
                                   child: _value.type == CategoryType.income
         ?  const Icon(Icons.arrow_circle_up,color: Colors.green,size: 30,)
         : const Icon(Icons.arrow_circle_down_outlined,color: Colors.red,size: 30,),

                                  // radius: 50,
                                  // child:Text(parseDate(_value.date),
                                  // textAlign: TextAlign.center,
                                  // ),
                                  // backgroundColor: _value.type == CategoryType.income? Colors.green : Colors.red,
                                  ),
                                title: Text('RS: ${_value.amount}',
                                style:const TextStyle(
                                  color:  Color.fromARGB(255, 12, 46, 62),
                                  fontWeight: FontWeight.w700,
                                ),
                                ),
                                //Text('RS ${_value.amount}'),
                                subtitle:Text(parseDate(_value.date),
                                style:const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                ),
                                //Text(_value.category.name),
                                //Text(_value.purpose),
                                 //Text(_value.category.name),
                                  // trailing: Text(_value.purpose),
                                  trailing:Column(
                                  children: [
                                    Text(_value.purpose,
                                    style: const TextStyle(
                                      color:  Color.fromARGB(255, 12, 46, 62),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15
                                    ),
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(_value.category.name,
                                    style: const TextStyle(
                                      color:  Color.fromARGB(255, 12, 46, 62),
                                      fontWeight: FontWeight.w500,
                                      ),),
                                  ],
                                ),
                              ),  
                            ),
                          );
                                  },
                                   separatorBuilder: (ctx,index){
                                    return //const SizedBox(height: 10, );
                                     const Divider(thickness: 1,);
                                   },
                                    itemCount: allTransactions.length),
                       ),
                    ]
                  );
                 },
                 ),
            ),
          ),
        ]
          ),  
      );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _splitedDate = _date.split(' ');
    return '${_splitedDate.last}\n${_splitedDate.first}';
    //'${date.day}\n${date.month}';
  }
}




