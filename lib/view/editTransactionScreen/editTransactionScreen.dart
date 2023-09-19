import 'package:flutter/material.dart';
import 'package:money_manager/db_function/transaction/transaction_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/widgets/home_screen.dart';
import '../../../models/transaction/transaction_model.dart';

class EditPage extends StatefulWidget {
  final TransactionModel transaction;

  const EditPage({required this.transaction, Key? key}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _amountTextEditingController = TextEditingController();
  final _purposeTextEditingController = TextEditingController();
  final _dateTextEditingController = TextEditingController();
  late DateTime _selectedDate;
  CategoryType _selectedCategoryType = CategoryType.expense;
  final _formKey = GlobalKey<FormState>();
  var _selectedCategoryId;
  bool _secureText = true;

  @override
  void initState() {
    _amountTextEditingController.text = widget.transaction.amount.toString();
    _purposeTextEditingController.text = widget.transaction.purpose;
    _selectedDate = widget.transaction.date;
    _selectedCategoryType = widget.transaction.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 46, 62),
        title: const Text('Edit Transaction'),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _purposeTextEditingController,
                  decoration: const InputDecoration(
                    labelText: 'Purpose',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a purpose';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _amountTextEditingController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _secureText = !_secureText;
                          });
                        },
                        icon: const Icon(
                          Icons.remove_red_eye,
                        )),
                  ),
                  obscureText: _secureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an Amount';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid numeric amount';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _dateTextEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Select date',
                    suffixIcon: Icon(Icons.date_range),
                  ),
                  readOnly: true,
                  onTap: () async {
                    final selectedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now(),
                    );
                    if (selectedDate != null) {
                      setState(() {
                        _selectedDate =
                            selectedDate; // Update _selectedDate with the selected date
                        _dateTextEditingController.text =
                            _selectedDate.toString();
                      });
                    }
                  },
                  validator: (value) {
                    if (_selectedDate == null) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: CategoryType.income,
                          groupValue: _selectedCategoryType,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategoryType = CategoryType.income;
                            });
                          },
                        ),
                        const Text('Income'),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: CategoryType.expense,
                          groupValue: _selectedCategoryType,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategoryType = CategoryType.expense;
                            });
                          },
                        ),
                        const Text('Expence'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      TransactionDB.instance.refresh();
                      updateTransaction();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }

                    //  Navigator.pop(context); // to Go back after updating
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 12, 46, 62)),
                  child: const Text('Update Transaction'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateTransaction() {
    final newAmount = double.parse(_amountTextEditingController.text);
    final newPurpose = _purposeTextEditingController.text;

    // Update the transaction's amount and purpose
    widget.transaction.amount = newAmount;
    widget.transaction.purpose = newPurpose;

    // Update the transaction's date
    widget.transaction.date = _selectedDate;

    // update the transaction  categorytype income or expence in radio
    widget.transaction.type = _selectedCategoryType;

    // Update the transaction in the database
    TransactionDB.instance.updateTransaction(widget.transaction);
  }
}
