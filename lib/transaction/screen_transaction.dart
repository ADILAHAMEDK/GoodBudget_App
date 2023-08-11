import 'package:flutter/material.dart';

class ScreenTransaction extends StatelessWidget {
  const ScreenTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemBuilder: (ctx,index){
        return Card(
          child: ListTile(
            leading: Text('12 dec'),
            title: Text('100000'),
            subtitle: Text('Travel'),
          ),
        );
    },
     separatorBuilder: (ctx,index){
      return Divider(thickness: 1,);

     },
      itemCount: 10);
  }
}