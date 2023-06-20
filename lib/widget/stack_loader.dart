import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StackLoader extends StatefulWidget {
  final Widget? child;
  final bool? showLoader;

  const StackLoader({Key? key, required this.child, required this.showLoader})
      : super(key: key);

  @override
  _StackLoaderState createState() => _StackLoaderState();
}

class _StackLoaderState extends State<StackLoader> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.showLoader == true
            ? IgnorePointer(
                child: WillPopScope(
                    onWillPop: () async {
                      return false;
                    },
                    child: widget.child??Container()
                ),
              )
            : widget.child ?? Container(),
        Positioned(
          left: 0.w,
          right: 0.w,
          top: 0.w,
          bottom: 0.w,
          child: widget.showLoader == true
              ? Center(
                  child: Container(
                    width: 70.w,
                    height: 70.w,
                    child: Image.asset("assets/images/loading-gif.gif"),
                  ),
                )
              : Container(),
        )
      ],
    );
  }
}
