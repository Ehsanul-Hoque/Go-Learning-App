import "package:advance_pdf_viewer/advance_pdf_viewer.dart";
import "package:app/app_config/resources.dart";
import "package:app/components/app_loading_anim.dart";
import "package:app/components/status_text.dart";
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";

class AppPdfViewer extends StatefulWidget {
  final String url;

  const AppPdfViewer({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<AppPdfViewer> createState() => _AppPdfViewerState();
}

class _AppPdfViewerState extends State<AppPdfViewer> {
  late Future<PDFDocument> pdfFuture;

  @override
  void initState() {
    super.initState();
    pdfFuture = PDFDocument.fromURL(widget.url);
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Res.color.pageBg,
      body: SafeArea(
        child: FutureBuilder<PDFDocument>(
          future: pdfFuture,
          builder: (
            BuildContext context,
            AsyncSnapshot<PDFDocument> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const AppLoadingAnim();
            }

            if (!snapshot.hasData) {
              return StatusText(Res.str.generalError);
            }

            return PDFViewer(
              document: snapshot.requireData,
              scrollDirection: Axis.vertical,
              pickerButtonColor: Res.color.progress,
              progressIndicator: const AppLoadingAnim(),
            );
          },
        ),
      ),
    );
  }
}
