import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage(
      {super.key, required this.url, this.fit, this.placeHolder});
  final String url;
  final BoxFit? fit;
  final Widget? placeHolder;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: double.maxFinite,
      imageUrl: url,
      cacheKey: url,
      progressIndicatorBuilder: (_, __, ___) =>
          placeHolder ?? const SizedBox.shrink(),
      errorWidget: (_, __, ___) => const Icon(Icons.error, color: Colors.red),
      fit: fit ?? BoxFit.cover,
    );
  }
}
