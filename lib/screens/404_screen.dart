import 'package:flutter/material.dart';

class Screen404 extends StatelessWidget {
  const Screen404({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [Text('404, the podcasts have run away!')],
        ),
      ),
    );
  }
}
