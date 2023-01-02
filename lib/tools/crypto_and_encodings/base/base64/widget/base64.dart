import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/logic/base.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/base/widget/base.dart';

class Base64 extends Base {
  Base64({Key key}) : super(key: key, encode: encodeBase64, decode: decodeBase64);
}
