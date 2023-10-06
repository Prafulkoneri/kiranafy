import 'package:flutter/material.dart';

class AppNetworkImages extends StatelessWidget {
  final double ? height;
  final double ? width;
  final BoxFit ? fit;
  final String ? imageUrl;
  final bool ? showShopImage;
  const AppNetworkImages({Key? key,this.width,this.height,this.fit,this.imageUrl,this.showShopImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Image.network(imageUrl??"",fit:fit, errorBuilder: (context,exception, stackTrace){
        print("hello");
        return showShopImage==true?Image.asset("assets/images/shop_image.png"):
          Image.asset("assets/images/profile_image.png",
          fit: BoxFit.cover,
        );
      },loadingBuilder: ( context, Widget child,
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
