import "package:app/app_config/resources.dart";
import "package:app/components/app_container.dart";
import "package:app/components/sliver_sized_box.dart";
import "package:app/components/two_line_info.dart";
import "package:app/pages/app_webview.dart";
import "package:app/utils/app_page_nav.dart";
import "package:flutter/material.dart" show Colors;
import "package:flutter/widgets.dart";
import "package:flutter_html/flutter_html.dart";
import "package:flutter_lorem/flutter_lorem.dart";
import "package:html/dom.dart" as dom show Element;

class CoursePlaylist extends StatefulWidget {
  final Map<String, String> course; // TODO Get data from calling activity

  const CoursePlaylist({
    Key? key,
    required this.course,
  }) : super(key: key);

  @override
  State<CoursePlaylist> createState() => _CoursePlaylistState();
}

class _CoursePlaylistState extends State<CoursePlaylist> {
  @override
  Widget build(BuildContext context) {
    String courseDescriptionHtml = """
        ${lorem().replaceAll("\n", "<br>")}
        <br><br>
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
          SliverToBoxAdapter(
            child: DefaultTextStyle(
              style: Res.textStyles.general,
              child: Html(
                // TODO Extract to component
                data: courseDescriptionHtml,
                style: <String, Style>{
                  "body": Style.fromTextStyle(Res.textStyles.general),
                  "h3": Style.fromTextStyle(Res.textStyles.label),
                  "h4": Style.fromTextStyle(Res.textStyles.labelSmall),
                  "h6": Style.fromTextStyle(Res.textStyles.subLabel),
                  "a": Style.fromTextStyle(Res.textStyles.link),
                },
                onLinkTap: (
                  String? url,
                  RenderContext renderContext,
                  Map<String, String> attributes,
                  dom.Element? element,
                ) {
                  PageNav.to(
                    context,
                    AppWebView(
                      url: url ??
                          "https://www.golearningbd.com", // TODO Extract the constant
                    ),
                  );
                },
              ),
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
                    widget.course["instructor"] ?? "", // TODO Get from API
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
            height: Res.dimen.xxlSpacingValue,
          ),
        ],
      ),
    );
  }
}
