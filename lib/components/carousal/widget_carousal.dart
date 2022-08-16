import "package:app/app_config/resources.dart";
import "package:cached_network_image/cached_network_image.dart";
import "package:flutter/widgets.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:smooth_page_indicator/smooth_page_indicator.dart";

class WidgetCarousal extends StatefulWidget {
  final List<String> images;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const WidgetCarousal({
    Key? key,
    required this.images,
    this.animationDuration,
    this.animationCurve,
  }) : super(key: key);

  @override
  State<WidgetCarousal> createState() => _WidgetCarousalState();
}

class _WidgetCarousalState extends State<WidgetCarousal> {
  late final PageController _pageController;
  late Duration animationDuration;
  late Curve animationCurve;
  late int currentPageIndex;

  @override
  void initState() {
    animationDuration =
        widget.animationDuration ?? Res.durations.defaultDuration;
    animationCurve = widget.animationCurve ?? Res.curves.defaultCurve;
    currentPageIndex = 0;

    _pageController = PageController(
      // initialPage: (999 ~/ widget.images.length) * widget.images.length,
      initialPage: 0,
      viewportFraction: Res.dimen.homeBannerViewportFraction,
    );

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AspectRatio(
          aspectRatio: Res.dimen.bannerAspectRatioAfterPadding,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            itemBuilder: (BuildContext context, int index) {
              String url = widget.images[index];
              bool activePage = (currentPageIndex == index);

              return AnimatedContainer(
                duration: animationDuration,
                curve: animationCurve,
                padding: EdgeInsets.all(
                  activePage
                      ? Res.dimen.smallSpacingValue
                      : Res.dimen.mlSpacingValue,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    Res.dimen.defaultBorderRadiusValue,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: url,
                    fadeInDuration: animationDuration,
                    fadeOutDuration: animationDuration,
                    fadeInCurve: animationCurve,
                    fadeOutCurve: animationCurve,
                    placeholder: (BuildContext context, String url) {
                      return Padding(
                        padding: EdgeInsets.all(Res.dimen.normalSpacingValue),
                        child: SvgPicture.asset(Res.assets.loadingSvg),
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            onPageChanged: (int newSelectedIndex) {
              setState(() {
                currentPageIndex = newSelectedIndex;
              });
            },
          ),
        ),
        SizedBox(
          height: Res.dimen.smallSpacingValue,
        ),
        SmoothPageIndicator(
          controller: _pageController, // PageController
          count: widget.images.length,
          effect: WormEffect(
            dotWidth: Res.dimen.carousalIndicatorItemSize,
            dotHeight: Res.dimen.carousalIndicatorItemSize,
            spacing: Res.dimen.carousalItemSpacing,
            dotColor: Res.color.carousalIndicator,
            activeDotColor: Res.color.carousalIndicatorActive,
          ), // your preferred effect
          onDotClicked: (int index) {
            _pageController.animateToPage(
              index,
              duration: animationDuration,
              curve: animationCurve,
            );
          },
        ),
      ],
    );
  }
}
