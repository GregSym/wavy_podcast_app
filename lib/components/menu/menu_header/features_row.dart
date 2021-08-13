import 'package:flutter/material.dart';

class MenuHeaderFeaturesRow extends StatelessWidget {
  const MenuHeaderFeaturesRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: null,
          icon: Icon(Icons.check),
        ),
        IconButton(
          onPressed: null,
          icon: Icon(Icons.circle),
        ),
        IconButton(
          onPressed: null,
          icon: Icon(Icons.share),
        ),
      ],
    );
  }
}
