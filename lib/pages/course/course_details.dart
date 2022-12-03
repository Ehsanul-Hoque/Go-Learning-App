import "package:app/app_config/resources.dart";
import "package:app/components/app_html/html_text.dart";
import "package:app/components/sliver_sized_box.dart";
import "package:app/network/models/api_courses/course_get_response.dart";
import "package:flutter/widgets.dart";

class CourseDetails extends StatefulWidget {
  final CourseGetResponse course;

  const CourseDetails({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    String courseDescriptionHtml =
        widget.course.description?.replaceAll(RegExp(r"</?figure.*?>"), "") ??
            "";

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Res.dimen.normalSpacingValue,
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverSizedBox(
            height: Res.dimen.normalSpacingValue,
          ),
          /*SliverToBoxAdapter(
            child: IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TwoLineInfo(
                      // TODO Get data from API
                      topText: "18",
                      bottomText: Res.str.videosAllCaps,
                      backgroundColor: Res.color.infoContainerBg1,
                    ),
                  ),
                  Expanded(
                    child: TwoLineInfo(
                      // TODO Get data from API
                      topText: "20",
                      bottomText: Res.str.quizzesAllCaps,
                      backgroundColor: Res.color.infoContainerBg2,
                    ),
                  ),
                  Expanded(
                    child: TwoLineInfo(
                      // TODO Get data from API
                      topText: "3.25h",
                      bottomText: Res.str.runtimeAllCaps,
                      backgroundColor: Res.color.infoContainerBg3,
                    ),
                  ),
                ],
              ),
            ),
          ),*/
          SliverToBoxAdapter(
            child: HtmlText(
              htmlText: courseDescriptionHtml,
            ),
          ),
          /*SliverSizedBox(
            height: Res.dimen.xxlSpacingValue,
          ),
          SliverToBoxAdapter(
            child: Text(
              " ${Res.str.instructor}",
              style: Res.textStyles.label,
            ),
          ),
          SliverSizedBox(
            height: Res.dimen.normalSpacingValue,
          ),
          SliverToBoxAdapter(
            child: AppContainer(
              margin: EdgeInsets.zero,
              shadow: const <BoxShadow>[],
              backgroundColor: Colors.grey.shade200,
              border: Border.all(
                color: Colors.grey.shade200,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    (widget.course["instructor"] as String?) ??
                        "", // TODO Get from API
                    style: Res.textStyles.labelSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "Dhaka Medical College", // TODO Get from API
                    style: Res.textStyles.general,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),*/
          SliverSizedBox(
            height: Res.dimen.pageBottomPaddingWithNavBar,
          ),
        ],
      ),
    );
  }
}
