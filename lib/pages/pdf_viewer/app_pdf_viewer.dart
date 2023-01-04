import "package:advance_pdf_viewer/advance_pdf_viewer.dart";
import "package:app/app_config/resources.dart";
import "package:app/components/app_loading_anim.dart";
import "package:app/components/status_text.dart";
import "package:app/network/notifiers/content_api_notifier.dart";
import "package:app/network/views/network_widget.dart";
import "package:app/pages/course/workers/content_worker.dart";
import "package:flutter/widgets.dart";
import "package:flutter_platform_widgets/flutter_platform_widgets.dart";
import "package:provider/provider.dart";

part "package:app/pages/pdf_viewer/app_pdf_viewer_part.dart";

class AppPdfViewer extends StatefulWidget {
  final String? url;
  final ContentWorker<String>? contentWorker;

  const AppPdfViewer({
    Key? key,
    this.url,
    this.contentWorker,
  })  : assert(url != null || contentWorker != null),
        super(key: key);

  @override
  State<AppPdfViewer> createState() => _AppPdfViewerState();
}

class _AppPdfViewerState extends State<AppPdfViewer> {
  late bool isValidUrl;
  Future<PDFDocument>? pdfFuture;

  @override
  void initState() {
    super.initState();
    isValidUrl = (widget.url ?? "").trim().isNotEmpty;

    if (isValidUrl) {
      pdfFuture ??= PDFDocument.fromURL(widget.url ?? "");
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Execute callback if page is mounted
        if (!mounted) return;

        widget.contentWorker?.loadContentData(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ContentWorker<String>? contentWorker = widget.contentWorker;
    Widget pdfViewer;

    if (isValidUrl) {
      pdfFuture ??= PDFDocument.fromURL(widget.url ?? "");
      pdfViewer = AppPdfViewerPart(pdfFuture: pdfFuture!);
    } else if (contentWorker != null) {
      return NetworkWidget(
        callStatusSelector: (BuildContext context) => context.select(
          (ContentApiNotifier? apiNotifier) =>
              contentWorker.getResponseCallStatus(context, apiNotifier),
        ),
        childBuilder: (BuildContext context) {
          String url = contentWorker.getResponseObject(context);
          pdfFuture ??= PDFDocument.fromURL(url);
          pdfViewer = AppPdfViewerPart(pdfFuture: pdfFuture!);
          return pdfViewer;
        },
      );
    } else {
      pdfViewer = StatusText(Res.str.generalError);
    }

    return PlatformScaffold(
      backgroundColor: Res.color.pageBg,
      body: SafeArea(
        child: pdfViewer,
      ),
    );
  }
}
