import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction_db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransaction();
  Future<void> deleteTransaction(String id);
  Future<void> updateTransaction(TransactionModel obj);
}

class TransactionDB implements TransactionDbFunctions {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }
  
  final ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier<List<TransactionModel>>([]); // Initialize with an empty list

  List<TransactionModel> _transactions = [];

  // add transaction function
  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getAllTransaction();
    _list.sort((first, second) => second.date.compareTo(first.date));

    _transactions.clear(); // Clear the list
    _transactions.addAll(_list); // Update with new data

    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransaction() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.delete(id);
    refresh();
  }

  @override
  Future<void> updateTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _db.put(obj.id, obj);
    refresh();
  }

  List<TransactionModel> get transactions => _transactions;
  List<TransactionModel> getTransactionsByDay() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    return transactions.where((transaction) {
      return transaction.date.year == today.year &&
          transaction.date.month == today.month &&
          transaction.date.day == today.day;
    }).toList();
  }

  List<TransactionModel> getTransactionsByWeek(DateTime monday, DateTime sunday) {
    final now = DateTime.now();
    final startOfWeek = DateTime(now.year, now.month, now.day - now.weekday);
    final endOfWeek = DateTime(now.year, now.month, now.day + (6 - now.weekday));
    

    return transactions.where((transaction) {
      return transaction.date.isAfter(startOfWeek) && transaction.date.isBefore(endOfWeek);
    }).toList();
  }

  List<TransactionModel> getTransactionsByMonth() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0);

    return transactions.where((transaction) {
      return transaction.date.isAfter(startOfMonth) && transaction.date.isBefore(endOfMonth);
    }).toList();
  }
}

