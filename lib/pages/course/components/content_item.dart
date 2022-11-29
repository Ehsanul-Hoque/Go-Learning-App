import "package:app/app_config/resources.dart";
import "package:app/components/app_circular_progress.dart";
import "package:app/components/app_container.dart";
import "package:app/components/floating_messages/app_snack_bar_content/app_snack_bar_content.dart";
import "package:app/components/floating_messages/enums/floating_messages_content_type.dart";
import "package:app/components/splash_effect.dart";
import "package:app/network/enums/api_contents/course_content_type.dart";
import "package:app/network/enums/network_call_status.dart";
import "package:app/network/models/api_contents/content_tree_get_response_model.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/network/views/network_widget_light.dart";
import "package:app/utils/extensions/context_extension.dart";
import "package:app/utils/typedefs.dart" show OnContentItemClickListener;
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/widgets.dart";
import "package:provider/provider.dart";

class ContentItem extends StatelessWidget {
  final CtgrContentsModel content;
  final bool isFirst, isSelected;
  final OnContentItemClickListener onContentClick;
  final double? leftMargin;

  const ContentItem({
    Key? key,
    required this.content,
    required this.isSelected,
    required this.onContentClick,
    this.isFirst = false,
    this.leftMargin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLocked = content.locked ?? true;

    return AppContainer(
      animated: true,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(
        top: isFirst ? Res.dimen.smallSpacingValue : Res.dimen.xsSpacingValue,
        left: leftMargin ?? Res.dimen.normalSpacingValue,
      ),
      backgroundColor: isSelected
          ? Res.color.contentItemSelectedBg
          : Res.color.contentItemBg,
      shadow: const <BoxShadow>[],
      child: SplashEffect(
        onTap: () => onContentClick(content),
        child: Padding(
          padding: EdgeInsets.all(Res.dimen.normalSpacingValue),
          child: Row(
            children: <Widget>[
              NetworkWidgetLight(
                callStatusSelector: (BuildContext context) {
                  return context.select((ContentApiNotifier? apiNotifier) {
                    String contentId = content.sId ?? "";
                    CourseContentType contentType =
                        content.contentType ?? CourseContentType.unknown;

                    if (contentId.isNotEmpty) {
                      switch (contentType) {
                        case CourseContentType.lecture:
                          return apiNotifier
                                  ?.lectureGetResponse(contentId)
                                  .callStatus ??
                              NetworkCallStatus.none;

                        // TODO handle other types of contents if available

                        case CourseContentType.unknown:
                          return NetworkCallStatus.none;
                      }
                    } else {
                      return NetworkCallStatus.none;
                    }
                  });
                },
                onStatusNoInternet: () => onStatusNoInternet(context),
                onStatusFailed: () => onStatusFailed(context),
                childBuilder:
                    (BuildContext context, NetworkCallStatus callStatus) {
                  Widget resultWidget;

                  if (callStatus == NetworkCallStatus.loading) {
                    resultWidget = AppCircularProgress(
                      dimension: Res.dimen.iconSizeFlutterDefault,
                      thickness: Res.dimen.circularProgressThicknessNarrow,
                      backgroundColor:
                          isSelected ? Res.color.progressBgOnDark : null,
                      color: isSelected ? Res.color.progressOnDark : null,
                    );
                  } else {
                    resultWidget = Icon(
                      CupertinoIcons.play_arrow_solid,
                      color: isLocked
                          ? Res.color.contentItemContentLocked
                          : isSelected
                              ? Res.color.contentItemContentSelected
                              : Res.color.videoItemIcon,
                    );
                  }

                  resultWidget = AnimatedSwitcher(
                    duration: Res.durations.defaultDuration,
                    switchInCurve: Res.curves.defaultCurve,
                    switchOutCurve: Res.curves.defaultCurve,
                    child: resultWidget,
                  );

                  return resultWidget;
                },
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

  void onStatusNoInternet(BuildContext context) {
    // TODO don't show snack bar from here.
    //  Instead show snack bar from page context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.showSnackBar(
        AppSnackBarContent(
          title: Res.str.noInternetTitle,
          message: Res.str.noInternetDescription,
          contentType: ContentType.help,
        ),
      );
    });
  }

  void onStatusFailed(BuildContext context) {
    // TODO don't show snack bar from here.
    //  Instead show snack bar from page context
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.showSnackBar(
        AppSnackBarContent(
          title: Res.str.errorTitle,
          message: Res.str.errorLoadingContent,
          contentType: ContentType.failure,
        ),
      );
    });
  }
}
