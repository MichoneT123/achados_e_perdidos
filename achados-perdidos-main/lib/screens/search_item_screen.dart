import 'package:flutter/material.dart';

class SearchItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Items'),
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          Navigator.pushNamed(context, '/add_item');
        },
          child: Text('Add Item'),
        ),
      ),
    );
  }
}
