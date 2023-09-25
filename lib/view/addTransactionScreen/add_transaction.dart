import 'package:flutter/material.dart';
import 'package:money_manager/controller/provider/addTransactionProvider.dart';
import 'package:money_manager/db_function/category/category_db.dart';
import 'package:money_manager/db_function/transaction/transaction_db.dart';
import 'package:money_manager/helpers/colors.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transaction/transaction_model.dart';
import 'package:provider/provider.dart';

class AddTransactionPage extends StatefulWidget {
  static const routeName = 'add transaction';
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategoryModel;
  bool _secureText = true;
  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final secureEye = Provider.of<AddTransactionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Transaction'),
        backgroundColor: AppColors.allBlue,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _purposeTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.allBlue),
                        ),
                        hintText: 'Description',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                        )),
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
                  // Amount
                  Consumer<AddTransactionProvider>(
                      builder: (context, addTransactionProvider, _) {
                    return TextFormField(
                      controller: _amountTextEditingController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                              onPressed: () {
                                // setState(() {
                                //   _secureText = !_secureText;
                                // });
                                addTransactionProvider.changeSecureText();
                              },
                              icon: Icon(
                                // Icons.remove_red_eye,
                                addTransactionProvider.isSecure
                                    ? Icons.remove_red_eye
                                    : Icons.visibility_off,
                              )),
                          hintText: 'Amount',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                          )),
                      obscureText: addTransactionProvider.isSecure,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an Amount';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid numeric amount';
                        }
                        return null;
                      },
                    );
                  }),

                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: _selectedDate == null
                            ? 'Select date'
                            : _selectedDate!.toString(),
                        suffixIcon: Icon(Icons.date_range)),
                    readOnly: true,
                    onTap: () async {
                      final _selectedDateTemp = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate:
                            DateTime.now().subtract(const Duration(days: 30)),
                        lastDate: DateTime.now(),
                      );
                      if (_selectedDateTemp == null) {
                        return;
                      } else {
                        print(_selectedDateTemp.toString());
                        setState(() {
                          _selectedDate = _selectedDateTemp;
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

                  // Category
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: CategoryType.income,
                            groupValue: _selectedCategorytype,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategorytype = CategoryType.income;
                                _categoryID = null;
                              });
                            },
                          ),
                          const Text('Income')
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: CategoryType.expense,
                            groupValue: _selectedCategorytype,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedCategorytype = CategoryType.expense;
                                _categoryID = null;
                              });
                            },
                          ),
                          const Text('Expence'),
                        ],
                      ),
                    ],
                  ),
                  // Category Type
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      hintText: 'Select phone number',
                      icon: Icon(
                        Icons.menu,
                        color: AppColors.allBlue,
                      ),
                    ),
                    // hint:const Text('Select Category'),
                    // icon:const Icon(Icons.menu,color: Color.fromARGB(255, 12, 46, 62) ,),
                    value: _categoryID,
                    items: (_selectedCategorytype == CategoryType.income
                            ? CategoryDB().incomeCategoryListListener
                            : CategoryDB().expenseCategoryListListener)
                        .value
                        .map((e) {
                      return DropdownMenuItem<String>(
                        value: e.id,
                        child: Text(e.name),
                        onTap: () {
                          _selectedCategoryModel = e;
                        },
                      );
                    }).toList(),
                    onChanged: (selectedValue) {
                      print(selectedValue);
                      setState(() {
                        _categoryID = selectedValue;
                      });
                    },
                    validator: (value) {
                      if (_categoryID == null) {
                        return 'Please select a phone number';
                      }
                      return null;
                    },
                  ),
                  // Submit
                  ElevatedButton(
                    onPressed: () {
                      // addTransaction();
                      // TransactionDB.instance.refresh();

                      if (_formKey.currentState!.validate() &&
                          _selectedDate != null) {
                        addTransaction();
                        TransactionDB.instance.refresh();
                        Navigator.of(context).pop();
                      }
                      // Navigator.of(context).pop();
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> AddTransactionPage()));
                    },
                    child: const SizedBox(
                      child: Text(
                        'Add',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      width: 400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;

    if (_purposeText.isEmpty ||
        _selectedCategoryModel == null ||
        _amountText.isEmpty ||
        _selectedDate == null ||
        double.tryParse(_amountText) == null) {
      return;
    }
    final _parsedAmount = double.tryParse(_amountText);
    if (_parsedAmount == null) {
      return;
    }

    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _selectedCategorytype!,
      category: _selectedCategoryModel!,
    );

    await TransactionDB.instance.addTransaction(_model);
    //  Navigator.of(context).pop();
  }
}
