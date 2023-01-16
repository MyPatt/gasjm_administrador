import 'package:flutter/material.dart';

class Handle extends StatelessWidget {
  const Handle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50.0,
        height: 5.0,
        margin: const EdgeInsets.only(bottom: 25.0),
        decoration: BoxDecoration(
          color: Colors.grey[400],
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
