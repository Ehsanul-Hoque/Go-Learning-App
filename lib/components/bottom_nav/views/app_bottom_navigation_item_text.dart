import "package:app/app_config/resources.dart";
import "package:flutter/widgets.dart";

class AppBottomNavigationItemText extends StatelessWidget {
  final double spaceBetweenIconAndText, textSize;
  final String text;
  final Axis navItemAxis;

  const AppBottomNavigationItemText({
    Key? key,
    required this.spaceBetweenIconAndText,
    required this.navItemAxis,
    required this.text,
    required this.textSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isHorizontal = (navItemAxis == Axis.horizontal);

    return Center(
      child: Padding(
        padding: EdgeInsets.only(
          left: isHorizontal ? spaceBetweenIconAndText : 0,
          top: !isHorizontal ? spaceBetweenIconAndText : 0,
        ),
        child: Text(
          text,
          style: Res.textStyles.general.copyWith(
            fontSize: textSize,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
