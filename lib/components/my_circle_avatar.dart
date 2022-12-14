import "dart:io";
import "dart:math";

import "package:app/app_config/resources.dart";
import "package:app/components/my_cached_image.dart";
import "package:app/utils/typedefs.dart" show ErrorBuilder, PlaceholderBuilder;
import "package:app/utils/utils.dart";
import "package:flutter/widgets.dart";
import "package:flutter_svg/flutter_svg.dart";

class MyCircleAvatar extends StatelessWidget {
  final File? imageFile;
  final String? imageUrl;
  final double radius;
  final double padding;
  final Color? backgroundColor;
  final List<BoxShadow>? shadow;
  final PlaceholderBuilder? placeholderBuilder;
  final ErrorBuilder? errorBuilder;

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
                ? SvgPicture.asset(
                    Res.assets.defaultAvatarSvg,
                    width: max(0, 2 * (radius - padding)),
                    height: max(0, 2 * (radius - padding)),
                  )
                : MyCachedImage(
                    imageUrl: imageUrl ?? "",
                    placeholder: placeholderBuilder ??
                        (BuildContext context, String url) {
                          return const SizedBox.shrink();
                        },
                    errorWidget: (
                      BuildContext context,
                      String url,
                      dynamic error,
                    ) {
                      if (url.isNotEmpty) {
                        Utils.log(
                          "Error while loading image: \"$url\"",
                          error: error,
                        );
                      }

                      if (errorBuilder != null) {
                        return errorBuilder!(context, url, error);
                      } else {
                        return SvgPicture.asset(
                          Res.assets.defaultAvatarSvg,
                          width: max(0, 2 * (radius - padding)),
                          height: max(0, 2 * (radius - padding)),
                        );
                      }
                    },
                  ),
      ),
    );
  }
}
