import "package:app/app_config/resources.dart";
import "package:app/components/app_button.dart";
import "package:app/components/floating_messages/app_dialog/models/app_dialog_button_model.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:flutter/material.dart" show AlertDialog;
import "package:flutter/widgets.dart";
import "package:flutter_svg/flutter_svg.dart";

class AppDialog extends StatelessWidget {
  final String title, message;
  final ContentType contentType;
  final List<AppDialogButtonModel> actionButtons;

  const AppDialog({
    Key? key,
    required this.title,
    required this.message,
    required this.contentType,
    this.actionButtons = const <AppDialogButtonModel>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HSLColor hsl = HSLColor.fromColor(contentType.color);
    final HSLColor hslDark =
        hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Res.dimen.largeBorderRadiusValue),
      ),
      backgroundColor: Res.color.containerBg,
      contentPadding: EdgeInsets.all(Res.dimen.smallSpacingValue),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      Res.dimen.mediumBorderRadiusValue,
                    ),
                    color: hsl.toColor(),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft:
                        Radius.circular(Res.dimen.mediumBorderRadiusValue),
                  ),
                  child: SvgPicture.asset(
                    Res.assets.cornerBubblesSvg,
                    height: Res.dimen.floatingMessagesBubbleImageSize,
                    width: Res.dimen.floatingMessagesBubbleImageSize,
                    color: hslDark.toColor(),
                  ),
                ),
              ),
              Positioned(
                top: Res.dimen.floatingMessagesTopBubbleTop,
                right: Res.dimen.appDialogTopBubbleRight,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      Res.assets.talkBubbleSvg,
                      height: Res.dimen.floatingMessagesTopBubbleSize,
                      color: hslDark.toColor(),
                    ),
                    Positioned(
                      top: Res.dimen.floatingMessagesTopBubbleIconTop,
                      child: SvgPicture.asset(
                        contentType.iconAsset,
                        height: Res.dimen.floatingMessagesTopBubbleIconHeight,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Res.dimen.largeSpacingValue),
                child: Center(
                  child: Text(
                    title,
                    style: Res.textStyles.label.copyWith(
                      color: Res.color.contentOnDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Res.dimen.largeSpacingValue,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Res.dimen.smallSpacingValue,
            ),
            child: Text(
              message,
              style: Res.textStyles.general,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Res.dimen.xxlSpacingValue,
          ),
          Row(
            children: actionButtons.map((AppDialogButtonModel buttonModel) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Res.dimen.xsSpacingValue,
                  ),
                  child: getButton(
                    buttonModel,
                    hsl.toColor(),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(
            height: Res.dimen.smallSpacingValue,
          ),
        ],
      ),
    );
  }

  Widget getButton(AppDialogButtonModel? buttonModel, Color defaultBgColor) {
    return (buttonModel != null)
        ? AppButton(
            text: Text(buttonModel.text),
            onTap: buttonModel.onTap,
            minHeight: Res.dimen.iconSizeNormal + Res.dimen.xsSpacingValue * 4,
            backgroundColor: buttonModel.bgColor ?? defaultBgColor,
            contentColor:
                buttonModel.contentColor ?? Res.color.buttonFilledContent,
            tintIconWithContentColor: false,
            borderRadius: Res.dimen.fullRoundedBorderRadiusValue,
          )
        : const SizedBox.shrink();
  }
}
