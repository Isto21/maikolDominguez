import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

typedef OnProgress = void Function(double progress);

class WidgetsGI {
  //ChipGi
  static Chip ChipGI(
    String label, {
    IconData? icon,
    VoidCallback? onDeleted,
  }) =>
      Chip(
        label: Text(label),
        onDeleted: onDeleted,
        avatar: icon != null ? Icon(icon) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      );

  //ImageNetworkGI
  static Widget ImageNetworkGI(
    String path, {
    String placeholderPath = "assets/imagen/placeholder.png",
    Widget? placeholderWidget,
    double? width,
    double? height,
    BoxFit fit = BoxFit.cover,
    bool withLoading = true,
    OnProgress? onProgress,
  }) {
    final placeholderImage = placeholderWidget ??
        Image(
          image: AssetImage(placeholderPath),
          width: width,
          height: height,
          fit: fit,
        );
    if (path.isEmpty) return placeholderImage;

    return Image.network(
      path,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress != null) {
          double progress = (loadingProgress.expectedTotalBytes != null)
              ? (loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!)
                  .toDouble()
              : -1;
          if (onProgress != null) onProgress(progress);
          return !withLoading
              ? placeholderImage
              : Container(
                  width: width,
                  height: height,
                  color: Colors.black12,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      value: progress != -1 ? progress : null,
                    ),
                  ),
                );
        }
        return FadeIn(child: child);
      },
      errorBuilder: (context, error, stackTrace) {
        return placeholderImage;
      },
    );
  }

  //CacheImageNetworkGI
//   static Widget CacheImageNetworkGI(
//     String path, {
//     String placeholderPath = "assets/imagen/placeholder.png",
//     Widget? placeholderWidget,
//     double? width,
//     double? height,
//     BoxFit fit = BoxFit.cover,
//     bool withLoading = true,
//     OnProgress? onProgress,
//   }) {
//     final placeholderImage = placeholderWidget ??
//         Image(
//           image: AssetImage(placeholderPath),
//           width: width,
//           height: height,
//           fit: fit,
//         );
//     if (path.isEmpty) return placeholderImage;

//     return CachedNetworkImage(
//       imageUrl: path,
//       width: width,
//       height: height,
//       fit: fit,
//       progressIndicatorBuilder: (context, url, downloadProgress) {
//         double progress =
//             downloadProgress.progress != null ? downloadProgress.progress! : -1;
//         if (onProgress != null) onProgress(progress);
//         return !withLoading
//             ? placeholderImage
//             : Container(
//                 width: width,
//                 height: height,
//                 color: Colors.black12,
//                 child: Center(
//                   child: CircularProgressIndicator(
//                     strokeWidth: 2,
//                     value: progress != -1 ? progress : null,
//                   ),
//                 ),
//               );
//       },
//       errorWidget: (context, url, error) => placeholderImage,
//     );
//   }
}
