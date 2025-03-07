import 'package:flutter/material.dart';
import 'package:gc_wizard/logic/tools/images_and_files/binary2image.dart';
import 'package:gc_wizard/widgets/tools/crypto_and_encodings/general_codebreakers/multi_decoder/gcw_multi_decoder_tool.dart';

const MDT_INTERNALNAMES_BINARY2IMAGE = 'multidecoder_tool_binary2image_title';

class MultiDecoderBinary2Image extends GCWMultiDecoderTool {
  MultiDecoderBinary2Image({Key key, int id, String name, Map<String, dynamic> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_BINARY2IMAGE,
            onDecode: (String input, String key) async {
              return await binary2image(input, false, false);
            },
            options: options);
}
