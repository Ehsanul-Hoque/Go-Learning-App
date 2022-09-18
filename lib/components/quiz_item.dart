import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/splash_effect.dart";
import "package:app/utils/typedefs.dart" show OnContentItemClickListener;
import "package:flutter/cupertino.dart" show CupertinoIcons;
import "package:flutter/widgets.dart";

class QuizItem extends StatelessWidget {
  final String title, quizId;
  final bool isLocked;
  final OnContentItemClickListener onQuizClick;

  const QuizItem({
    Key? key,
    required this.title,
    required this.quizId,
    required this.isLocked,
    required this.onQuizClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.only(
        bottom: Res.dimen.normalSpacingValue,
      ),
      backgroundColor: Res.color.contentItemBg,
      child: SplashEffect(
        onTap: () => onQuizClick(quizId, isLocked),
        child: Padding(
          padding: EdgeInsets.all(Res.dimen.normalSpacingValue),
          child: Row(
            children: <Widget>[
              Icon(
                CupertinoIcons.pencil_circle,
                color: isLocked
                    ? Res.color.contentItemContentLocked
                    : Res.color.quizItemIcon,
              ),
              SizedBox(
                width: Res.dimen.normalSpacingValue,
              ),
              Expanded(
                child: Text(
                  title,
                  style: Res.textStyles.labelSmall.copyWith(
                    color: isLocked
                        ? Res.color.contentItemContentLocked
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
                  color: Res.color.contentItemLock,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
