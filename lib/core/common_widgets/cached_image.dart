import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage({
    super.key,
    required this.url,
    this.fit,
  });
  final String url;
  final BoxFit? fit;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: double.maxFinite,
      imageUrl: url,
      progressIndicatorBuilder: (c, _, __) => const SizedBox.shrink(),
      errorWidget: (context, url, error) =>
          const Icon(Icons.error, color: Colors.red),
      fit: fit ?? BoxFit.cover,
    );
  }
}
