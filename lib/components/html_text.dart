import "package:app/app_config/resources.dart";
import "package:app/pages/app_webview.dart";
import "package:app/utils/app_page_nav.dart";
import "package:flutter/widgets.dart";
import "package:flutter_html/flutter_html.dart";
import "package:html/dom.dart" as dom show Element;

class HtmlText extends StatelessWidget {
  final String htmlText;
  final TextStyle? defaultTextStyle;
  final Map<String, Style>? tagsStyle;
  final double fontSizeMultiplier;
  final TextAlign? textAlign;

  const HtmlText({
    Key? key,
    required this.htmlText,
    this.defaultTextStyle,
    this.tagsStyle,
    this.fontSizeMultiplier = 1,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle defaultTextStyle =
        this.defaultTextStyle ?? Res.textStyles.general;
    Map<String, Style> tagsStyle = this.tagsStyle ?? <String, Style>{};

    tagsStyle["body"] ??= Style.fromTextStyle(defaultTextStyle);
    tagsStyle["h1"] ??= Style.fromTextStyle(Res.textStyles.h1);
    tagsStyle["h2"] ??= Style.fromTextStyle(Res.textStyles.h2);
    tagsStyle["h3"] ??= Style.fromTextStyle(Res.textStyles.h3);
    tagsStyle["h4"] ??= Style.fromTextStyle(Res.textStyles.h4);
    tagsStyle["h5"] ??= Style.fromTextStyle(Res.textStyles.h5);
    tagsStyle["h6"] ??= Style.fromTextStyle(Res.textStyles.h6);
    tagsStyle["a"] ??= Style.fromTextStyle(Res.textStyles.link);

    for (MapEntry<String, Style> element in tagsStyle.entries) {
      element.value.fontSize = FontSize(
        (element.value.fontSize?.size ?? Res.dimen.fontSizeNormal) *
            fontSizeMultiplier,
      );

      tagsStyle[element.key] = element.value;
    }

    return DefaultTextStyle(
      style: defaultTextStyle,
      textAlign: textAlign,
      child: Html(
        data: htmlText,
        style: tagsStyle,
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
    );
  }
}
