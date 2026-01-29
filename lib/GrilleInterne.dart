import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Grilleinterne extends StatelessWidget {


  const Grilleinterne(size) : super();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(9, (x) {
        return Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 0.3)),
        );
      }),
    );
  }
}