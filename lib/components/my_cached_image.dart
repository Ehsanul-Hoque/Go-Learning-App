import "package:app/app_config/resources.dart";
import "package:app/utils/typedefs.dart" show ErrorBuilder, PlaceholderBuilder;
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/widgets.dart";
import "package:flutter_svg/flutter_svg.dart";

class MyCachedImage extends StatelessWidget {
  final String? imageUrl;
  final PlaceholderBuilder? placeholder;
  final ErrorBuilder? errorWidget;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final BoxFit? fit;

  const MyCachedImage({
    Key? key,
    required this.imageUrl,
    this.placeholder,
    this.errorWidget,
    this.animationDuration,
    this.animationCurve,
    this.fit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Duration animationDuration =
        this.animationDuration ?? Res.durations.defaultDuration;
    Curve animationCurve = this.animationCurve ?? Res.curves.defaultCurve;

    if (imageUrl == null || imageUrl!.isEmpty) {
      return const SizedBox.shrink();
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fadeInDuration: animationDuration,
      fadeOutDuration: animationDuration,
      fadeInCurve: animationCurve,
      fadeOutCurve: animationCurve,
      placeholder: placeholder ??
          (BuildContext context, String url) {
            return Padding(
              padding: EdgeInsets.all(Res.dimen.normalSpacingValue),
              child: SvgPicture.asset(Res.assets.loadingSvg),
            );
          },
      errorWidget: errorWidget ??
          (BuildContext context, String url, dynamic error) =>
              const SizedBox.shrink(),
      fit: fit ?? BoxFit.cover,
    );
  }
}
