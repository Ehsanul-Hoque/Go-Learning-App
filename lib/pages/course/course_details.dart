import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/html_text.dart";
import "package:app/components/sliver_sized_box.dart";
import "package:app/components/two_line_info.dart";
import "package:flutter/material.dart" show Colors;
import "package:flutter/widgets.dart";
import "package:flutter_lorem/flutter_lorem.dart";

class CourseDetails extends StatefulWidget {
  final Map<String, Object> course; // TODO Get data from calling activity

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
    String courseDescriptionHtml = """
        ${lorem().replaceAll("\n", "<br>")}
        <br><br>
        <h1>H1 Label</h1>
        <h2>H2 Label</h2>
        <h3>H3 Label</h3>
        <h4>H4 Label</h4>
        <h5>H5 Label</h5>
        <h6>H6 Label</h6>
        <a href='https://github.com'>websites</a>
      """;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Res.dimen.normalSpacingValue,
      ),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverSizedBox(
            height: Res.dimen.normalSpacingValue,
          ),
          SliverToBoxAdapter(
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
          ),
          SliverToBoxAdapter(
            child: HtmlText(
              htmlText: courseDescriptionHtml,
            ),
          ),
          SliverSizedBox(
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
          ),
          SliverSizedBox(
            height: Res.dimen.pageBottomPaddingWithNavBar,
          ),
        ],
      ),
    );
  }
}
