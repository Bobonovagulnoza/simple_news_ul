import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImage extends StatelessWidget {
  final String? image;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const AppImage({
    super.key,
    required this.image,
    this.width = 100,
    this.height = 100,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  bool get _isSvg => image != null && image!.toLowerCase().endsWith('.svg');

  bool get _isNetwork =>
      image != null &&
      (image!.startsWith('http://') || image!.startsWith('https://'));

  bool get isAsset =>
      image != null &&
      !(image!.startsWith('http://') || image!.startsWith('https://'));

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(8);

    if (image == null || image!.isEmpty) {
      return _buildPlaceholder();
    }

    return ClipRRect(
      borderRadius: radius,
      child: _isNetwork
          ? _isSvg
                ? SvgPicture.network(
                    image!,
                    width: width,
                    height: height,
                    fit: fit,
                    placeholderBuilder: (_) => _buildPlaceholder(),
                  )
                : CachedNetworkImage(
                    imageUrl: image!,
                    width: width,
                    height: height,
                    fit: fit,
                    placeholder: (_, __) => _buildPlaceholder(),
                    errorWidget: (_, __, ___) => _buildPlaceholder(),
                  )
          : _isSvg
          ? SvgPicture.asset(image!, width: width, height: height, fit: fit)
          : Image.asset(
              image!,
              width: width,
              height: height,
              fit: fit,
              errorBuilder: (_, __, ___) => _buildPlaceholder(),
            ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.image_not_supported_outlined,
            color: Colors.grey,
            size: 40,
          ),
          SizedBox(height: 8),
          Text(
            "Image not found.",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
