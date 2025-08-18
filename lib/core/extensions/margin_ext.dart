import 'package:flutter/cupertino.dart';

extension WidgetMargin on Widget{

  Widget withMargin(EdgeInsets margin){
    return Container(margin: margin, child: this,);
  }
}