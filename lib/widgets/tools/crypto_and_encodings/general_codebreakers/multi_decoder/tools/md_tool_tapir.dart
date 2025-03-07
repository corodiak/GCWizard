import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/tapir.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_TAPIR = 'multidecoder_tool_tapir_title';

class MultiDecoderToolTapir extends GCWMultiDecoderTool {
  MultiDecoderToolTapir({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_TAPIR,
            onDecode: (String input, String key) {
              return decryptTapir(input, key);
            },
            requiresKey: true,
            options: options);
}
