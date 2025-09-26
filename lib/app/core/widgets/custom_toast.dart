
import 'package:fluttertoast/fluttertoast.dart';

class AppUtils{
  static void showToast(String msg){
    Fluttertoast.showToast(msg: msg, gravity: ToastGravity.TOP);
  }
}