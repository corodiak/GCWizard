import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/teletypewriter.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/teletypewriter/teletypewriter.dart';

class ALGOL extends Teletypewriter {
  ALGOL({Key key}) : super(key: key, defaultCodebook: TeletypewriterCodebook.ALGOL, codebook: null);
}
