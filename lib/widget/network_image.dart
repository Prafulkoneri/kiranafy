import 'package:flutter/material.dart';

class AppNetworkImages extends StatelessWidget {
  final double ? height;
  final double ? width;
  final BoxFit ? fit;
  final String ? imageUrl;
  const AppNetworkImages({Key? key,this.width,this.height,this.fit,this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Image.network(imageUrl??"",fit:fit,  loadingBuilder: ( context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },),
    );
  }
}
