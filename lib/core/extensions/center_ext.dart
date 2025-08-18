import 'package:flutter/widgets.dart';

extension CenterToWidget on Widget {
  Widget setCenter() {
    return Center(
      child: this,
    );
  }
}
