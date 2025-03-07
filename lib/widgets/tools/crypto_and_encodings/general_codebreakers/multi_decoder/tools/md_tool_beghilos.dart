import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/beghilos.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_BEGHILOS = 'multidecoder_tool_beghilos_title';

class MultiDecoderToolBeghilos extends GCWMultiDecoderTool {
  MultiDecoderToolBeghilos({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_BEGHILOS,
            onDecode: (String input, String key) {
              return decodeBeghilos(input);
            },
            options: options);
}
