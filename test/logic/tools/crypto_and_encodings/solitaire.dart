import "package:flutter_test/flutter_test.dart";
import 'package:gc_wizard/logic/tools/crypto_and_encodings/solitaire.dart';

void main() {
  group("Solitaire.encryptSolitaire:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : 'DONOTUSEPC', 'key': '', 'expectedOutput' : 'HLXMB TKKTJ', 'keyStream': 'DWJXHYRFDG'},
      {'input' : 'AAAAAAAAAA', 'key': '', 'expectedOutput' : 'EXKYI ZSGEH', 'keyStream': 'DWJXHYRFDG'},
      {'input' : 'AAAAAAAAAAAAAAA', 'key': 'FOO', 'expectedOutput' : 'ITHZU JIWGR FARMW', 'keyStream': 'HSGYTIHVFQEZQLV'},
      {'input' : 'AAAA AAAAAA AAAAA', 'key': 'FOO', 'expectedOutput' : 'ITHZU JIWGR FARMW', 'keyStream': 'HSGYTIHVFQEZQLV'},
      {'input' : 'AAAAAAAAAAAAAAAX', 'key': 'FOO', 'expectedOutput' : 'ITHZU JIWGR FARMW BQTSP', 'keyStream': 'HSGYTIHVFQEZQLVDSVUR'},
      {'input' : '*SOLITAIRE', 'key': 'CRYPTONOMICON', 'expectedOutput' : 'KIRAK SFJAN', 'keyStream': 'RTFRQRWRVP'},
      {'input' : '*SOLITAIRE1234567', 'key': 'CRYPTONOMICON', 'expectedOutput' : 'KIRAK SFJAN', 'keyStream': 'RTFRQRWRVP'},
      {'input' : '*solitaire1234567', 'key': 'CRYPTONOMICON', 'expectedOutput' : 'KIRAK SFJAN', 'keyStream': 'RTFRQRWRVP'},
      {'input' : '*SOLItaire1234567', 'key': 'CRYPTONOMICON', 'expectedOutput' : 'KIRAK SFJAN', 'keyStream': 'RTFRQRWRVP'},
      {'input' : '*SOLItaire1234567 *%&/', 'key': 'CRYPTONOMICON', 'expectedOutput' : 'KIRAK SFJAN', 'keyStream': 'RTFRQRWRVP'},
      {'input' : '*%&/', 'key': '', 'expectedOutput' : '', 'keyStream': ''},
      {'input' : 'ABC*%&/', 'key': '', 'expectedOutput' : 'EYMVF', 'keyStream': 'DWJXH'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, key: ${elem['key']}', () {
        var _actual = encryptSolitaire(elem['input'], elem['key']);
        expect(_actual.output, elem['expectedOutput']);
        expect(_actual.keyStream, elem['keyStream']);
      });
    });
  });

  group("Solitaire.decryptSolitaire:", () {
    List<Map<String, dynamic>> _inputsToExpected = [
      {'input' : 'HLXMB TKKTJ', 'key': '', 'expectedOutput' : 'DONOTUSEPC', 'keyStream': 'DWJXHYRFDG'},
      {'input' : 'EXKYI ZSGEH', 'key': '', 'expectedOutput' : 'AAAAAAAAAA', 'keyStream': 'DWJXHYRFDG'},
      {'input' : 'ITHZU JIWGR FARMW', 'key': 'FOO', 'expectedOutput' : 'AAAAAAAAAAAAAAA', 'keyStream': 'HSGYTIHVFQEZQLV'},
      {'input' : 'ITHZUJIWGRFARMW', 'key': 'FOO', 'expectedOutput' : 'AAAAAAAAAAAAAAA', 'keyStream': 'HSGYTIHVFQEZQLV'},
      {'input' : 'ITHZU JIWGR FARMW BQTSP', 'key': 'FOO', 'expectedOutput' : 'AAAAAAAAAAAAAAAXXXXX', 'keyStream': 'HSGYTIHVFQEZQLVDSVUR'},
      {'input' : 'KIRAK SFJAN1234567', 'key': 'CRYPTONOMICON', 'expectedOutput' : 'SOLITAIREX', 'keyStream': 'RTFRQRWRVP'},
      {'input' : 'KIRak SFJAN123456', 'key': 'CRYPTONOMICON', 'expectedOutput' : 'SOLITAIREX', 'keyStream': 'RTFRQRWRVP'},
      {'input' : 'KIRak SFJAN12345671234567 *%&/', 'key': 'CRYPTONOMICON', 'expectedOutput' : 'SOLITAIREX', 'keyStream': 'RTFRQRWRVP'},
      {'input' : '*%&/', 'key': '', 'expectedOutput' : '', 'keyStream': ''},
      {'input' : 'EYMVF', 'key': '', 'expectedOutput' : 'ABCXX', 'keyStream': 'DWJXH'},
    ];

    _inputsToExpected.forEach((elem) {
      test('input: ${elem['input']}, key: ${elem['key']}', () {
        var _actual = decryptSolitaire(elem['input'], elem['key']);
        expect(_actual.output, elem['expectedOutput']);
      });
    });
  });
}