import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/science_and_technology/quadratic_equation.dart';

void main() {
  group("QuadratcEquation.SolveEquation:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'a' : null, 'b' : null, 'c' : null, 'expectedOutput' : ['']},
      {'a' : null, 'b' : '',   'c' : '',   'expectedOutput' : ['']},
      {'a' : null, 'b' : null, 'c' : null, 'expectedOutput' : ['']},
      {'a' : '',   'b' : '',   'c' : '',   'expectedOutput' : ['']},
      {'a' : '',   'b' : null, 'c' : null, 'expectedOutput' : ['']},
      {'a' : '',   'b' : '',   'c' : '',   'expectedOutput' : ['']},

      {'a' : '0.0', 'b' : '0.0', 'c' : '0.0', 'expectedOutput' : ['quadratic_equation_hint_a_b_null', 'NaN', 'NaN']},
      {'a' : '1.0', 'b' : '1.0', 'c' : '1.0', 'expectedOutput' : ['quadratic_equation_hint_complex', '-0.5 + i * 0.8660254', '-0.5 - i * 0.8660254']},
      {'a' : '1.0', 'b' : '2.0', 'c' : '1.0', 'expectedOutput' : ['-1.0', '-1.0']},
      {'a' : '1.0', 'b' : '2.0', 'c' : '0.0', 'expectedOutput' : ['0.0', '-2.0']},
      {'a' : '1.0', 'b' : '2.0', 'c' : '0.5', 'expectedOutput' : ['-0.29289322', '-1.70710678']},
// https://de.wikipedia.org/wiki/Quadratische_Gleichung#L%C3%B6sung_der_a-b-c-Formel_bei_negativer_Diskriminante
      {'a' : '1.0', 'b' : '-1.0', 'c' : '-1', 'expectedOutput' : ['1.61803399', '-0.61803399']},
      {'a' : '4.0', 'b' : '-12.0', 'c' : '-40', 'expectedOutput' : ['5.0', '-2.0']},
      {'a' : '1.0', 'b' : '2', 'c' : '-35', 'expectedOutput' : ['5.0', '-7.0']},
      {'a' : '1.0', 'b' : '-4.0', 'c' : '4', 'expectedOutput' : ['2.0', '2.0']},
      {'a' : '1', 'b' : '12.0', 'c' : '37', 'expectedOutput' : ['quadratic_equation_hint_complex', '-6.0 + i * 1.0', '-6.0 - i * 1.0']},

      {'a' : '1.0/1', 'b' : '-8.0/2', 'c' : '4*1', 'expectedOutput' : ['2.0', '2.0']},
      {'a' : '1/1', 'b' : '-2.0 - 2', 'c' : '2*2', 'expectedOutput' : ['2.0', '2.0']},
      {'a' : '1/1', 'b' : '-*4.0', 'c' : '2*2', 'expectedOutput' : ['']},
    ];

    _inputsToExpected.forEach((elem) {
      test('a: ${elem['a']}, b: ${elem['b']}, c: ${elem['c']}', () {
        var _actual = solveQuadraticEquation(elem['a'], elem['b'], elem['c']);
        var coordinate = _actual.values;
        for (int i = 0; i < coordinate.length; i++) {
          expect(coordinate.elementAt(i), elem['expectedOutput'][i]);
        }
      });
    });
  });

}