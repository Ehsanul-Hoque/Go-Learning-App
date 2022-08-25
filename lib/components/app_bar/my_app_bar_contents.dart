part of "package:app/components/app_bar/my_app_bar.dart";

class MyAppBarContents extends StatelessWidget {
  final MyAppBarConfig config;
  final double avatarCenterX, avatarRadius;

  const MyAppBarContents({
    Key? key,
    required this.config,
    required this.avatarCenterX,
    required this.avatarRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AppBarWithAvatarPainter(
        color: config.backgroundColor,
        avatarCenterX: avatarCenterX,
        avatarRadius: avatarRadius,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Positioned(
            bottom: -avatarRadius,
            left: avatarCenterX - avatarRadius,
            child: MyCircleAvatar(
              imageUrl: SampleData.avatar, // TODO Get profile picture from API
              radius: avatarRadius,
              padding: 1,
            ),
          ),
          Positioned(
            left: avatarRadius == 0
                ? Res.dimen.smallSpacingValue
                : (avatarCenterX + avatarRadius),
            top: MediaQuery.of(context).padding.top,
            right: Res.dimen.smallSpacingValue,
            bottom: 0,
            child: Row(
              children: <Widget>[
                ...config.startActions,
                SizedBox(
                  width: Res.dimen.smallSpacingValue,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: config.centerTitle
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.start,
                    children: <Widget>[
                      if (config.title != null)
                        DefaultTextStyle(
                          style: config.titleStyle,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          textAlign: config.centerTitle
                              ? TextAlign.center
                              : TextAlign.start,
                          child: config.title!,
                        ),
                      if (config.subtitle != null)
                        DefaultTextStyle(
                          style: config.subtitleStyle,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          textAlign: config.centerTitle
                              ? TextAlign.center
                              : TextAlign.start,
                          child: Text(config.subtitle!),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  width: Res.dimen.smallSpacingValue,
                ),
                ...config.endActions,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
