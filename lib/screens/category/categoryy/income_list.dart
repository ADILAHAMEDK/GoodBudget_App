import 'package:flutter/material.dart';
import 'package:money_manager/db_function/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

class IncomeList extends StatelessWidget {
  const IncomeList({super.key});

 @override
  Widget build(BuildContext context) {
    return  ValueListenableBuilder(
      valueListenable: CategoryDB().incomeCategoryListListener,
     builder: (BuildContext ctx, List<CategoryModel> newlist,Widget? _){
      return ListView.separated(
      itemBuilder: (ctx,index){
        final category = newlist[index];
        return Card(
          child: ListTile(
            title:Text(category.name),
            trailing: IconButton(onPressed: (){
              CategoryDB.instance.deleteCategory(category.id);
            },
             icon:const Icon(Icons.delete,color: Colors.red,)),
          ),
        );
    },
     separatorBuilder: (ctx,index){
      return const Divider(thickness: 1,);
     },
      itemCount: newlist.length,
      );
     },
     );
  }
}