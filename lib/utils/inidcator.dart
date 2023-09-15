import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIndicator extends Decoration {
  final BoxPainter _painter;
  CustomIndicator({required Color color, required double radius})
      : _painter = _CustomIndicator(color, radius);
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _painter;
//   throw UnimplementedError();
// }
}

class _CustomIndicator extends BoxPainter {
  final Paint _paint;
  final double radius;
  _CustomIndicator(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Offset customOffset = offset +
        Offset(configuration.size!.width / 2.w,
            configuration.size!.height - radius - 5.w);
    //canvas.drawCircle(customOffset, radius, _paint);
    canvas.drawRRect(
        RRect.fromRectAndCorners(
          topRight: Radius.circular(radius),
          topLeft: Radius.circular(radius),
          Rect.fromCenter(
            center: customOffset,
            width: configuration.size!.width,
            height: 5.w,
          ),
        ),
        _paint);
  }
}
