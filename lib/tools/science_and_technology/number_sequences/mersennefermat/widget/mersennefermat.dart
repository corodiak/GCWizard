import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_check/widget/numbersequences_check.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_containsdigits/widget/numbersequences_containsdigits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_digits/widget/numbersequences_digits.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_nthnumber/widget/numbersequences_nthnumber.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/base/numbersequences_range/widget/numbersequences_range.dart';
import 'package:gc_wizard/tools/science_and_technology/number_sequences/logic/number_sequence.dart';

class NumberSequenceMersenneFermatCheckNumber extends NumberSequenceCheckNumber {
  NumberSequenceMersenneFermatCheckNumber() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxIndex: 111111);
}

class NumberSequenceMersenneFermatDigits extends NumberSequenceDigits {
  NumberSequenceMersenneFermatDigits() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxDigits: 1111);
}

class NumberSequenceMersenneFermatRange extends NumberSequenceRange {
  NumberSequenceMersenneFermatRange() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxIndex: 111111);
}

class NumberSequenceMersenneFermatNthNumber extends NumberSequenceNthNumber {
  NumberSequenceMersenneFermatNthNumber() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxIndex: 111111);
}

class NumberSequenceMersenneFermatContainsDigits extends NumberSequenceContainsDigits {
  NumberSequenceMersenneFermatContainsDigits() : super(mode: NumberSequencesMode.MERSENNE_FERMAT, maxIndex: 11111);
}
