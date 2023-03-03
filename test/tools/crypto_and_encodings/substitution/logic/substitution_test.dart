import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/tools/crypto_and_encodings/substitution/logic/substitution.dart';

void main() {
  group("Substitution.substitution:", () {
    List<Map<String, Object?>> _inputsToExpected = [
      {'input' : null, 'substitution': null, 'caseSensitive': true, 'expectedOutput' : ''},
      {'input' : '', 'substitution': null, 'caseSensitive': true, 'expectedOutput' : ''},
      {'input' : null, 'substitution': <String, String>{}, 'caseSensitive': true, 'expectedOutput' : ''},
      {'input' : 'ABC', 'substitution': <String, String>{}, 'caseSensitive': true, 'expectedOutput' : 'ABC'},
      {'input' : 'Abc123', 'substitution': <String, String>{}, 'caseSensitive': true, 'expectedOutput' : 'Abc123'},
      {'input' : 'ABC', 'substitution': {'': '1'}, 'caseSensitive': true, 'expectedOutput' : 'ABC'},

      {'input' : 'ABCDEF', 'substitution': {'A': '1', 'B':'2', 'F': '6'}, 'caseSensitive': true, 'expectedOutput' : '12CDE6'},
      {'input' : 'ABCDEF', 'substitution': {'A': '1', 'b':'2', 'f': '6'}, 'caseSensitive': true, 'expectedOutput' : '1BCDEF'},
      {'input' : 'abCDEF', 'substitution': {'A': '1', 'b':'2', 'f': '6'}, 'caseSensitive': true, 'expectedOutput' : 'a2CDEF'},
      {'input' : 'ABCDEF', 'substitution': {'A': '1', 'b':'2', 'f': '6'}, 'caseSensitive': false, 'expectedOutput' : '12CDE6'},
      {'input' : 'abCDEF', 'substitution': {'A': '1', 'b':'2', 'f': '6'}, 'caseSensitive': false, 'expectedOutput' : '12CDE6'},

      {'input' : 'ABBBA', 'substitution': {'BB': '1'}, 'caseSensitive': true, 'expectedOutput' : 'A1BA'},
      {'input' : 'ABCD', 'substitution': {'A': '1', 'BC': '2', 'BCD': '3'}, 'caseSensitive': true, 'expectedOutput' : '13'},
      {'input' : 'ABAB', 'substitution': {'A': 'B', 'B': 'A'}, 'caseSensitive': true, 'expectedOutput' : 'BABA'},
      {'input' : 'ABAB', 'substitution': {'A': 'B', 'B': 'C', 'C': 'A'}, 'caseSensitive': true, 'expectedOutput' : 'BCBC'},

      {'input' : 'CADBEFAGB', 'substitution': {'A': 'B', 'B': 'A'}, 'caseSensitive': true, 'expectedOutput' : 'CBDAEFBGA'},
      {'input' : 'CADBEFAGB', 'substitution': {'A': 'B', 'B': 'C', 'C': 'A'}, 'caseSensitive': true, 'expectedOutput' : 'ABDCEFBGC'},
    ];

    for (var elem in _inputsToExpected) {
      test('input: ${elem['input']}, substitution: ${elem['substitution']}, caseSensitive: ${elem['caseSensitive']}', () {


        var _actual = substitution(elem['input'] as String?, elem['substitution'] as Map<String, String>, caseSensitive: elem['caseSensitive'] as bool);
        expect(_actual, elem['expectedOutput']);
      });
    }
  });
}