import "dart:io";

import "package:app/app_config/resources.dart";
import "package:app/utils/utils.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/cupertino.dart";

class MyCircleAvatar extends StatelessWidget {
  final File? imageFile;
  final String? imageUrl;
  final double radius;
  final double padding;
  final Color? backgroundColor;
  final List<BoxShadow>? shadow;
  final Widget Function(BuildContext context, String url)? placeholderBuilder;
  final Widget Function(BuildContext context, String url, dynamic error)?
      errorBuilder;

  const MyCircleAvatar({
    Key? key,
    this.imageFile,
    required String? imageUrl,
    this.radius = 18,
    this.padding = 0,
    this.backgroundColor,
    this.shadow,
    this.placeholderBuilder,
    this.errorBuilder,
  })  : imageUrl = imageUrl ?? "",
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = this.backgroundColor ?? Res.color.appBarAvatarBg;

    return Container(
      width: 2 * radius,
      height: 2 * radius,
      padding: EdgeInsets.all(padding), // Border radius
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: shadow ??
            <BoxShadow>[
              Res.shadows.normal,
            ],
      ),
      child: ClipOval(
        child: imageFile != null
            ? Image.file(
                imageFile!,
                fit: BoxFit.cover,
              )
            : (imageUrl?.isEmpty != false)
                ? Icon(
                    CupertinoIcons.person_crop_circle,
                    size: 2 * (radius - padding),
                    color: Res.color.appBarAvatarIcon,
                  )
                : CachedNetworkImage(
                    imageUrl: imageUrl ?? "",
                    fadeInDuration: Res.durations.defaultDuration,
                    fadeOutDuration: Res.durations.defaultDuration,
                    fit: BoxFit.cover,
                    placeholder: placeholderBuilder ??
                        (BuildContext context, String url) {
                          return const SizedBox.shrink();
                        },
                    errorWidget:
                        (BuildContext context, String url, dynamic error) {
                      if (url.isNotEmpty) {
                        Utils.log(
                          "Error while loading image: \"$url\"",
                          error: error,
                        );
                      }

                      if (errorBuilder != null) {
                        return errorBuilder!(context, url, error);
                      } else {
                        return Icon(
                          CupertinoIcons.person_crop_circle,
                          size: 2 * (radius - padding),
                          color: Res.color.appBarAvatarIcon,
                        );
                      }
                    },
                  ),
      ),
    );
  }
}
