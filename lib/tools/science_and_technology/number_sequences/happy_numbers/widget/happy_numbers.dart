import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_check/widget/numbersequences_check.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits/widget/numbersequences_containsdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_digits/widget/numbersequences_digits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber/widget/numbersequences_nthnumber.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_range/widget/numbersequences_range.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/logic/number_sequence.dart';

class NumberSequenceHappyNumbersCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceHappyNumbersCheckNumber() : super(mode: NumberSequencesMode.HAPPY_NUMBERS, maxIndex: 142);
}

class NumberSequenceHappyNumbersDigits extends NumberSequenceDigits {
  NumberSequenceHappyNumbersDigits() : super(mode: NumberSequencesMode.HAPPY_NUMBERS, maxDigits: 4);
}

class NumberSequenceHappyNumbersRange extends NumberSequenceRange {
  NumberSequenceHappyNumbersRange() : super(mode: NumberSequencesMode.HAPPY_NUMBERS, maxIndex: 142);
}

class NumberSequenceHappyNumbersNthNumber extends NumberSequenceNthNumber {
  NumberSequenceHappyNumbersNthNumber() : super(mode: NumberSequencesMode.HAPPY_NUMBERS, maxIndex: 142);
}

class NumberSequenceHappyNumbersContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceHappyNumbersContainsDigits() : super(mode: NumberSequencesMode.HAPPY_NUMBERS, maxIndex: 142);
}
