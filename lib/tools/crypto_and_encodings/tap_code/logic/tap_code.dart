import 'package:gc_wizard/common/alphabets.dart';
import 'package:gc_wizard/tools/crypto_and_encodings/polybios/logic/polybios.dart';
import 'package:gc_wizard/utils/logic_utils/common_utils.dart';
import 'package:gc_wizard/utils/logic_utils/constants.dart';
import 'package:gc_wizard/utils/logic_utils/string_utils.dart';

const TAPCODE_KEY = '12345';

_generateAlphabet(mode) {
  return applyAlphabetModification(alphabet_AZString, mode);
}

String encryptTapCode(String input, {AlphabetModificationMode mode: AlphabetModificationMode.J_TO_I}) {
  if (input == null || input.length == 0) return '';

  input = removeAccents(input.toUpperCase());
  input = input.replaceAll(RegExp(r'[^A-Z]'), '');
  input = applyAlphabetModification(input, mode);

  return encryptPolybios(input, TAPCODE_KEY,
          mode: PolybiosMode.CUSTOM, fillAlphabet: _generateAlphabet(mode), modificationMode: mode)
      .output;
}

String decryptTapCode(String input, {AlphabetModificationMode mode: AlphabetModificationMode.J_TO_I}) {
  var output = decryptPolybios(input, TAPCODE_KEY,
      mode: PolybiosMode.CUSTOM, fillAlphabet: _generateAlphabet(mode), modificationMode: mode);
  if (output == null) return '';

  return output.output;
}
