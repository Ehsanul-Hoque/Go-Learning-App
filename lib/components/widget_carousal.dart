import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class WidgetCarousal extends StatefulWidget {
  final List<String> images;

  const WidgetCarousal({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  State<WidgetCarousal> createState() => _WidgetCarousalState();
}

class _WidgetCarousalState extends State<WidgetCarousal> {
  late final PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: (9999 ~/ widget.images.length) * widget.images.length,
      viewportFraction: 0.8,
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
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          String url = widget.images[index % widget.images.length];

          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: Res.dimen.smallSpacingValue,
            ),
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(Res.dimen.defaultBorderRadiusValue),
              child: Image.network(
                url,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        onPageChanged: (int newSelectedIndex) {},
      ),
    );
  }
}
