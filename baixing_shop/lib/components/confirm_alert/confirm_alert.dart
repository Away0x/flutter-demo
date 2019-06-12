import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef BtnCallback = void Function();

class ConfirmAlert {

  final String cancelButtonText;
  final String sureButtonText;
  final BtnCallback cancelButtonPress;
  final BtnCallback sureButtonPress;
  final AlertType alertType;
  final String title;
  final BuildContext context;
  Alert alert;
  
  ConfirmAlert({
    @required this.title,
    @required this.context,
    this.cancelButtonText = '取消',
    this.sureButtonText = '确定',
    this.cancelButtonPress,
    this.sureButtonPress,
    this.alertType = AlertType.info,
  }) {
    alert = Alert(
      context: context,
      title: title,
      type: alertType,
      buttons: [
        // 取消按钮
        DialogButton(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(116, 116, 191, 1), Color.fromRGBO(52, 138, 199, 1)],
          ),
          child: Text(
            cancelButtonText,
            style: TextStyle(color: Colors.white, fontSize: ScreenUtil.getInstance().setSp(30)),
          ),
          onPressed: () {
            Navigator.pop(context);
            if (cancelButtonPress != null) {
              cancelButtonPress();
            }
          },
        ),
        // 确定按钮
        DialogButton(
          color: Colors.pink,
          child: Text(
            sureButtonText,
            style: TextStyle(color: Colors.white, fontSize: ScreenUtil.getInstance().setSp(30)),
          ),
          onPressed: () {
            Navigator.pop(context);
            if (sureButtonPress != null) {
              sureButtonPress();
            }
          },
        ),
      ],
    );
  }

  show() {
    alert.show();
  }

}