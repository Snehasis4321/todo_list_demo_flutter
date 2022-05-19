import 'package:flutter/material.dart';

class Congratulations extends StatelessWidget {
  const Congratulations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Congrats You unlocked the Secret.")),
    );
  }
}
