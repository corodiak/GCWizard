import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/crypto_and_encodings/esoteric_programming_languages/whitespace_language.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_WHITESPACE = 'whitespace_language_title';

class MultiDecoderToolEsotericLanguageWhitespace extends GCWMultiDecoderTool {
  MultiDecoderToolEsotericLanguageWhitespace({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_ESOTERIC_LANGUAGE_WHITESPACE,
            optionalKey: true,
            onDecode: (String input, String key) {
              try {
                var outputFuture = interpreterWhitespace(input, key, timeOut: 1000);
                return Future<String>.value(outputFuture.then((output) => output.error || output.output?.isEmpty ? null : output.output));
              } catch (e) {}
              return null;
            },
      options: options);
}