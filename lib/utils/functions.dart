import 'package:flutter/material.dart';

class Functions {
  Color setImportanceBackGroundColor({required int importance}) {
    switch (importance) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.red.shade200;
      case 3:
        return Colors.yellow;
      default:
        return Colors.green;
    }
  }
}
