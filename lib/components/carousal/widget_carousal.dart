import "package:app/app_config/resources.dart";
import "package:app/components/my_cached_image.dart";
import "package:flutter/widgets.dart";
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
          aspectRatio: Res.dimen.homeBannerAspectRatioWidth /
              (Res.dimen.homeBannerAspectRatioHeight *
                  Res.dimen.homeBannerViewportFraction),
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            itemBuilder: (BuildContext context, int index) {
              String url = widget.images[index];
              bool activePage = (currentPageIndex == index);

              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return AnimatedContainer(
                    duration: animationDuration,
                    curve: animationCurve,
                    padding: EdgeInsets.symmetric(
                      vertical: activePage
                          ? (constraints.maxHeight * 0.01)
                          : (constraints.maxHeight * 0.05),
                      horizontal: activePage
                          ? (constraints.maxWidth * 0.01)
                          : (constraints.maxWidth * 0.05),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        Res.dimen.defaultBorderRadiusValue,
                      ),
                      child: MyCachedImage(
                        imageUrl: url,
                        animationDuration: animationDuration,
                        animationCurve: animationCurve,
                      ),
                    ),
                  );
                },
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
          height: Res.dimen.normalSpacingValue,
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
