import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/cow.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_COW = 'cow_title';

class MultiDecoderToolEsotericLanguageCow extends GCWMultiDecoderTool {
  MultiDecoderToolEsotericLanguageCow({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_COW,
            optionalKey: true,
            onDecode: (String input, String key) {
              try {
                CowOutput output = interpretCow(input, STDIN: key);
                if (output.error == '')
                  return output.output?.isEmpty ? null : output.output;
              } catch (e) {}
              return null;
            },
            options: options);
}