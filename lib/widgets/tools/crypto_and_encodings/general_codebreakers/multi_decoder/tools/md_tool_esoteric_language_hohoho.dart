import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/hohoho.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_HOHOHO = 'hohoho_title';

class MultiDecoderToolEsotericLanguageHohoho extends GCWMultiDecoderTool {
  MultiDecoderToolEsotericLanguageHohoho({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_HOHOHO,
            optionalKey: true,
            onDecode: (String input, String key) {
              try {
                var output = interpretHohoho(input, STDIN: key);
                if (output != null) {
                  return output.output;
                }
              } catch (e) {}
              return null;
            },
            options: options);
}
