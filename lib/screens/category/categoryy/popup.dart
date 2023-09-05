import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_manager/db_function/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategoryNotifier = ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (ctx) {
      return Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            
            
            child: SimpleDialog(
              //backgroundColor: const Color.fromARGB(255, 12, 46, 62),
              title: const Text('Add Category'),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: _nameEditingController,
                          inputFormatters: [LengthLimitingTextInputFormatter(10)],
                          decoration: const InputDecoration(
                            hintText: 'Category Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a category name';
                            }
                            return null; // Validation passed
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            RadioButton(title: 'Income', type: CategoryType.income),
                            RadioButton(title: 'Expense', type: CategoryType.expense),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                              final _name = _nameEditingController.text;
                              final _type = selectedCategoryNotifier.value;
                              final _category = CategoryModel(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                name: _name,
                                type: _type,
                              );
                
                              CategoryDB.instance.insertCategory(_category);
                              Navigator.of(ctx).pop();
                            }
                          },
                          child: const Text('Add'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;

  const RadioButton({
    Key? key,
    required this.title,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategoryNotifier,
          builder: (BuildContext ctx, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: selectedCategoryNotifier.value,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategoryNotifier.value = value;
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}




