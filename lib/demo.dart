import 'package:flutter/material.dart';

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Page de démo")),
      body: Center(
        child: Text("Hello world!"),
      ),
    );
  }
}

