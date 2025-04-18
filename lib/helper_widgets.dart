import 'package:flutter/material.dart';

void loadDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => Center(child: CircularProgressIndicator()),
  );
}
