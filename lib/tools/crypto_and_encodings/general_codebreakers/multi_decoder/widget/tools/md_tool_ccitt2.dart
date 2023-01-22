import 'package:flutter/material.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_dropdown.dart';
import 'package:gc_wizard/common_widgets/dropdowns/gcw_stateful_dropdown.dart';
import 'package:gc_wizard/i18n/app_localizations.dart';

import 'package:gc_wizard/tools/crypto_and_encodings/general_codebreakers/multi_decoder/widget/multi_decoder.dart';
import 'package:gc_wizard/tools/science_and_technology/teletypewriter/logic/teletypewriter.dart';
import 'package:gc_wizard/tools/science_and_technology/numeral_bases/logic/numeral_bases.dart';
import 'package:gc_wizard/utils/logic_utils/common_utils.dart';

const MDT_INTERNALNAMES_CCITT2 = 'multidecoder_tool_ccitt2_title';
const MDT_CCITT2_OPTION_MODE = 'common_mode';

const MDT_CCITT2_OPTION_MODE_DENARY = 'common_numeralbase_denary';
const MDT_CCITT2_OPTION_MODE_BINARY = 'common_numeralbase_binary';

class MultiDecoderToolCcitt2 extends AbstractMultiDecoderTool {
  MultiDecoderToolCcitt2({Key key, int id, String name, Map<String, dynamic> options, BuildContext context})
      : super(
            key: key,
            id: id,
            name: name,
            internalToolName: MDT_INTERNALNAMES_CCITT2,
            onDecode: (String input, String key) {
              if (options[MDT_CCITT2_OPTION_MODE] == MDT_CCITT2_OPTION_MODE_BINARY) {
                return decodeTeletypewriter(
                    textToBinaryList(input).map((value) {
                      return int.tryParse(convertBase(value, 2, 10));
                    }).toList(),
                    TeletypewriterCodebook.CCITT_ITA2_1931);
              } else
                return decodeTeletypewriter(textToIntList(input), TeletypewriterCodebook.CCITT_ITA2_1931);
            },
            options: options,
            configurationWidget: MultiDecoderToolConfiguration(widgets: {
              MDT_CCITT2_OPTION_MODE: GCWStatefulDropDown(
                value: options[MDT_CCITT2_OPTION_MODE],
                onChanged: (newValue) {
                  options[MDT_CCITT2_OPTION_MODE] = newValue;
                },
                items: [MDT_CCITT2_OPTION_MODE_DENARY, MDT_CCITT2_OPTION_MODE_BINARY].map((mode) {
                  return GCWDropDownMenuItem(
                    value: mode,
                    child: i18n(context, mode),
                  );
                }).toList(),
              )
            }));
}
