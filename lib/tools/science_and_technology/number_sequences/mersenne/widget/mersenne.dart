import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_check/widget/numbersequences_check.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits/widget/numbersequences_containsdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_digits/widget/numbersequences_digits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber/widget/numbersequences_nthnumber.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_range/widget/numbersequences_range.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/logic/number_sequence.dart';

class NumberSequenceMersenneCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceMersenneCheckNumber() : super(mode: NumberSequencesMode.MERSENNE, maxIndex: 111111);
}

class NumberSequenceMersenneDigits extends NumberSequenceDigits {
  NumberSequenceMersenneDigits() : super(mode: NumberSequencesMode.MERSENNE, maxDigits: 1111);
}

class NumberSequenceMersenneRange extends NumberSequenceRange {
  NumberSequenceMersenneRange() : super(mode: NumberSequencesMode.MERSENNE, maxIndex: 111111);
}

class NumberSequenceMersenneNthNumber extends NumberSequenceNthNumber {
  NumberSequenceMersenneNthNumber() : super(mode: NumberSequencesMode.MERSENNE, maxIndex: 111111);
}

class NumberSequenceMersenneContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceMersenneContainsDigits() : super(mode: NumberSequencesMode.MERSENNE, maxIndex: 11111);
}
