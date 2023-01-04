import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/splash_effect.dart";
import "package:app/pages/course/enums/course_content_type.dart";
import "package:app/network/models/api_contents/content_tree_get_response.dart";
import "package:app/utils/typedefs.dart" show OnContentItemClickListener;
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/widgets.dart";

class ContentItem extends StatelessWidget {
  final ContentTreeGetResponseContents content;
  final bool isFirst, isSelected, hasCourseEnrolled;
  final OnContentItemClickListener onContentClick;
  final double? leftMargin;

  const ContentItem({
    Key? key,
    required this.hasCourseEnrolled,
    required this.content,
    required this.isSelected,
    required this.onContentClick,
    this.isFirst = false,
    this.leftMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLocked = content.isActuallyLocked(hasCourseEnrolled);
    CourseContentType contentType =
        CourseContentType.valueOf(content.contentType);

    return AppContainer(
      animated: true,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(
        top: isFirst ? Res.dimen.smallSpacingValue : Res.dimen.xsSpacingValue,
        left: leftMargin ?? Res.dimen.normalSpacingValue,
      ),
      backgroundColor: isSelected ? contentType.color : Res.color.contentItemBg,
      shadow: const <BoxShadow>[],
      child: SplashEffect(
        onTap: () => onContentClick(content),
        child: Padding(
          padding: EdgeInsets.all(Res.dimen.normalSpacingValue),
          child: Row(
            children: <Widget>[
              Icon(
                contentType.iconData,
                color: isLocked
                    ? Res.color.contentItemContentLocked
                    : isSelected
                        ? Res.color.contentItemContentSelected
                        : contentType.color,
              ),
              SizedBox(
                width: Res.dimen.normalSpacingValue,
              ),
              Expanded(
                child: Text(
                  content.title ?? "",
                  style: Res.textStyles.labelSmall.copyWith(
                    color: isLocked
                        ? Res.color.contentItemContentLocked
                        : isSelected
                            ? Res.color.contentItemContentSelected
                            : Res.color.contentItemText,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              if (isLocked) ...<Widget>[
                SizedBox(
                  width: Res.dimen.normalSpacingValue,
                ),
                Icon(
                  CupertinoIcons.lock_circle,
                  color: isSelected
                      ? Res.color.contentItemContentSelected
                      : Res.color.contentItemLock,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
