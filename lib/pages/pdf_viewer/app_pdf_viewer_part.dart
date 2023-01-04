part of "package:app/pages/pdf_viewer/app_pdf_viewer.dart";

class AppPdfViewerPart extends StatelessWidget {
  final Future<PDFDocument> pdfFuture;

  const AppPdfViewerPart({
    Key? key,
    required this.pdfFuture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PDFDocument>(
      future: pdfFuture,
      builder: (
        BuildContext context,
        AsyncSnapshot<PDFDocument> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const AppLoadingAnim();
        }

        if ((snapshot.connectionState == ConnectionState.none) ||
            !snapshot.hasData) {
          return StatusText(Res.str.generalError);
        }

        return PDFViewer(
          document: snapshot.requireData,
          scrollDirection: Axis.vertical,
          pickerButtonColor: Res.color.progress,
          progressIndicator: const AppLoadingAnim(),
        );
      },
    );
  }
}
