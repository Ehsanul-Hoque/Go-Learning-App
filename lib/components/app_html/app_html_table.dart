import "dart:math";

import "package:app/utils/utils.dart";
import "package:flutter_layout_grid/flutter_layout_grid.dart";
import "package:flutter/material.dart";
import "package:flutter_html/flutter_html.dart";

/// The CustomRender function that will render the <table> HTML tag
CustomRender appHtmlTableRender() => CustomRender.widget(
      widget: (
        RenderContext context,
        List<InlineSpan> Function() buildChildren,
      ) {
        return CssBoxWidget(
          key: context.key,
          style: context.style,
          child: LayoutBuilder(
            builder: (_, BoxConstraints constraints) =>
                _layoutCells(context, constraints),
          ),
        );
      },
    );

/// A CustomRenderMatcher for matching the <table> HTML tag
CustomRenderMatcher appHtmlTableMatcher() => (RenderContext context) {
      return context.tree.element?.localName == "table";
    };

Widget _layoutCells(RenderContext context, BoxConstraints constraints) {
  final List<TableRowLayoutElement> rows = <TableRowLayoutElement>[];
  List<TrackSize> columnSizes = <TrackSize>[];
  for (StyledElement child in context.tree.children) {
    if (child is TableStyleElement) {
      Utils.log("[0] child is TableStyleElement");
      // Map <col> tags to predetermined column track sizes
      columnSizes = child.children
          .where((StyledElement c) => c.name == "col")
          .map((StyledElement c) {
            final int span = int.tryParse(c.attributes["span"] ?? "1") ?? 1;
            final String? colWidth = c.attributes["width"];
            return List<TrackSize>.generate(span, (int index) {
              if (colWidth != null && colWidth.endsWith("%")) {
                if (!constraints.hasBoundedWidth) {
                  // In a horizontally unbounded container;
                  // always wrap content instead of applying flex
                  return const IntrinsicContentTrackSize();
                }
                final double? percentageSize =
                    double.tryParse(colWidth.substring(0, colWidth.length - 1));
                return percentageSize != null && !percentageSize.isNaN
                    ? FlexibleTrackSize(percentageSize * 0.01)
                    : const IntrinsicContentTrackSize();
              } else if (colWidth != null) {
                final double? fixedPxSize = double.tryParse(colWidth);
                return fixedPxSize != null
                    ? FixedTrackSize(fixedPxSize)
                    : const IntrinsicContentTrackSize();
              } else {
                return const IntrinsicContentTrackSize();
              }
            });
          })
          .expand((List<TrackSize> element) => element)
          .toList(growable: false);
    } else if (child is TableSectionLayoutElement) {
      Utils.log("[1] child is TableStyleElement");
      rows.addAll(child.children.whereType());
    } else if (child is TableRowLayoutElement) {
      Utils.log("[2] child is TableStyleElement");
      rows.add(child);
    }
  }

  // All table rows have a height intrinsic to their (spanned) contents
  final List<IntrinsicContentTrackSize> rowSizes =
      List<IntrinsicContentTrackSize>.generate(
    rows.length,
    (_) => const IntrinsicContentTrackSize(),
  );

  // Calculate column bounds
  int columnMax = 0;
  List<int> rowSpanOffsets = <int>[];
  for (final TableRowLayoutElement row in rows) {
    final int cols = row.children.whereType<TableCellElement>().fold(
              0,
              (int value, TableCellElement child) => value + child.colspan,
            ) +
        rowSpanOffsets.fold<int>(0, (int offset, int child) => child);
    columnMax = max(cols, columnMax);
    rowSpanOffsets = <int>[
      ...rowSpanOffsets
          .map((int value) => value - 1)
          .where((int value) => value > 0),
      ...row.children
          .whereType<TableCellElement>()
          .map((TableCellElement cell) => cell.rowspan - 1),
    ];
  }

  Utils.log("Column max = $columnMax");

  // Place the cells in the rows/columns
  final List<GridPlacement> cells = <GridPlacement>[];
  final List<int> columnRowOffset = List<int>.generate(columnMax, (_) => 0);
  final List<int> columnColSpanOffset = List<int>.generate(columnMax, (_) => 0);
  int rowI = 0;
  for (TableRowLayoutElement row in rows) {
    int columnI = 0;
    for (StyledElement child in row.children) {
      if (columnI > columnMax - 1) {
        break;
      }
      if (child is TableCellElement) {
        while (columnRowOffset[columnI] > 0) {
          columnRowOffset[columnI] = columnRowOffset[columnI] - 1;
          columnI +=
              columnColSpanOffset[columnI].clamp(1, columnMax - columnI - 1);
        }
        int colSpan = min(child.colspan, columnMax - columnI);
        cells.add(
          GridPlacement(
            columnStart: columnI,
            columnSpan: colSpan,
            rowStart: rowI,
            rowSpan: min(child.rowspan, rows.length - rowI),
            child: CssBoxWidget(
              style: child.style
                  .merge(row.style), //TODO padding/decoration(color/border)
              child: SizedBox(
                width: constraints.hasBoundedWidth
                    ? (constraints.maxWidth / columnMax * colSpan)
                    : double.infinity,
                height: double.infinity,
                child: Container(
                  alignment: child.style.alignment ??
                      context.style.alignment ??
                      Alignment.centerLeft,
                  child: CssBoxWidget.withInlineSpanChildren(
                    children: <InlineSpan>[
                      context.parser.parseTree(context, child),
                    ],
                    style: child.style, //TODO updated this. Does it work?
                  ),
                ),
              ),
            ),
          ),
        );
        columnRowOffset[columnI] = child.rowspan - 1;
        columnColSpanOffset[columnI] = child.colspan;
        columnI += child.colspan;
      }
    }
    while (columnI < columnRowOffset.length) {
      columnRowOffset[columnI] = columnRowOffset[columnI] - 1;
      columnI++;
    }
    rowI++;
  }

  // Create column tracks
  // (insofar there were no colgroups that already defined them)
  List<TrackSize> finalColumnSizes = columnSizes.take(columnMax).toList();
  finalColumnSizes += List<TrackSize>.generate(
    max(0, columnMax - finalColumnSizes.length),
    (_) => const IntrinsicContentTrackSize(),
  );

  if (finalColumnSizes.isEmpty || rowSizes.isEmpty) {
    // No actual cells to show
    return const SizedBox();
  }

  return LayoutGrid(
    gridFit: GridFit.loose,
    columnSizes: finalColumnSizes,
    rowSizes: rowSizes,
    children: cells,
  );
}
