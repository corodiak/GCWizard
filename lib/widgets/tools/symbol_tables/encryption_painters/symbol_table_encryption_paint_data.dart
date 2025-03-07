import 'package:flutter/material.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/encryption_painters/symbol_table_encryption_default.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/encryption_painters/symbol_table_encryption_sizes.dart';
import 'package:gc_wizard/widgets/tools/symbol_tables/symbol_table_data.dart';

class SymbolTablePaintData {
  Canvas canvas;
  SymbolTableData data;
  SymbolTableEncryptionSizes sizes;
  List<int> imageIndexes;
  Function onCanvasChanged;

  SymbolTablePaintData({
    this.canvas,
    this.sizes,
    this.data,
    this.imageIndexes,
    this.onCanvasChanged
  });
}

class SymbolTableEncryptionPainter extends CustomPainter {
  final SymbolTablePaintData paintData;
  final SymbolTableEncryption encryption;

  const SymbolTableEncryptionPainter({this.paintData, this.encryption});

  @override
  void paint(Canvas canvas, Size size) {
    paintData.canvas = canvas;
    encryption.paint(paintData);
  }

  @override
  bool shouldRepaint(SymbolTableEncryptionPainter oldDelegate) => true;
}