import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
enum SnackType {
  error,
  success,
  invalidated,
  info,

  /// only works in debug mode
  debug,

  /// only works in debug mode
  debugError,
}

class Utils{

  static ScaffoldFeatureController showPrimarySnackbar(BuildContext context, text, {SnackType? type}) {
    ScaffoldMessenger.of(context).clearSnackBars();

    Color? color, textColor;
    switch (type) {
      case SnackType.error:
        debugPrint('\x1B[35mError: $text\x1B[0m');

        color = const Color(0xFFDC3545);
        textColor = Colors.white;
        break;
      case SnackType.invalidated:
        debugPrint('\x1B[35mInvalidated: $text\x1B[0m');

        color = const Color(0xFFDC3545);
        textColor = Colors.white;
        break;
      case SnackType.success:
        color = const Color(0xFF28A745);
        textColor = Colors.white;
        break;
      case SnackType.info:
        color = Colors.grey;
        break;
      case SnackType.debug:
        if (kReleaseMode) break;
        debugPrint('\x1B[33mDebug: $text\x1B[0m');
        color = const Color(0xFFFFC107);
        textColor = const Color(0xFF343A40);
        text = 'Debug: $text';
        break;
      case SnackType.debugError:
        if (kReleaseMode) break;
        debugPrint('\x1B[31mDebugError: $text\x1B[0m');
        color = const Color.fromARGB(255, 7, 110, 255);
        textColor = Colors.white;
        text = 'Debug Error: $text';
        break;
      default:
        color = Colors.grey;
        break;
    }

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        // margin: isOverSheet ? EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 1.6) : null,
        behavior: SnackBarBehavior.floating,
        // duration: Duration(seconds:1),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: textColor,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        content: Text(
          text ?? '',
          style: TextStyle(
            color:textColor,
          fontSize: 14.sp
          ),
          maxLines: 4,
        ),
        backgroundColor: color,
      ),
    );
  }
}