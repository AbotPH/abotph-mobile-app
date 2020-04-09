import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Map<String, ToastColors> configuration = {
  "ToastStatus.SUCCESS": new ToastColors(Colors.lightGreen, Colors.white),
  "ToastStatus.WARNING": new ToastColors(Colors.deepOrange, Colors.white),
  "ToastStatus.INFO": new ToastColors(Colors.lightBlueAccent, Colors.white),
  "ToastStatus.ERROR": new ToastColors(Colors.redAccent, Colors.white)
};

enum ToastStatus {
  SUCCESS,
  WARNING,
  INFO
}

class ToastColors {
  Color backgroundColor;
  Color textColor;
  ToastColors(this.backgroundColor, this.textColor);
}

class ToastUtil {
  static show(String message, ToastStatus status, { ToastGravity gravity = ToastGravity.BOTTOM, Toast duration = Toast.LENGTH_SHORT }){
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: configuration[status.toString()].backgroundColor,
        textColor: configuration[status.toString()].textColor,
        gravity: gravity,
        toastLength: duration);
  }

  static cancelAll(){
    Fluttertoast.cancel();
  }
}
