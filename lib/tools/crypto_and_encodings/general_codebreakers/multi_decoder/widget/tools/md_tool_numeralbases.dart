import 'package:flutter/material.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/widget/multi_decoder.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/widget/numeralbase_spinner.dart';

const MDT_INTERNALNAMES_NUMERALBASES = 'multidecoder_tool_numeralbases_title';
const MDT_NUMERALBASES_OPTION_FROM = 'multidecoder_tool_numeralbases_option_from';

class MultiDecoderToolNumeralBases extends AbstractMultiDecoderTool {
  MultiDecoderToolNumeralBases({
    Key? key,
    required int id,
    required String name,
    required Map<String, Object?> options})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_NUMERALBASES,
            onDecode: (String input, String key) {
              return input
                  .split(RegExp(r'\s+'))
                  .where((element) => element.isNotEmpty)
                  .map((element) => convertBase(element, toIntOrDefault(options[MDT_NUMERALBASES_OPTION_FROM], 10), 10))
                  .join(' ');
            },
            options: options,
            configurationWidget: MultiDecoderToolConfiguration(widgets: {
              MDT_NUMERALBASES_OPTION_FROM: NumeralBaseSpinner(
                value: toIntOrDefault(options[MDT_NUMERALBASES_OPTION_FROM], 10),
                onChanged: (value) {
                  options[MDT_NUMERALBASES_OPTION_FROM] = value;
                },
              )
            }));
}
