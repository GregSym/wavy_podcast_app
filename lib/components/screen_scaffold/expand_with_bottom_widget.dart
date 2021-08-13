import 'package:flutter/material.dart';

/// A more generic tool for enmeshing a height ubounded view with a fixed height
/// small widget
class ExpandWithBottomWidget extends StatelessWidget {
  final Widget child;
  final Widget bottomWidget;
  const ExpandWithBottomWidget(
      {Key? key, required this.child, required this.bottomWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: child,
          ),
          bottomWidget,
        ],
      ),
    );
  }
}
