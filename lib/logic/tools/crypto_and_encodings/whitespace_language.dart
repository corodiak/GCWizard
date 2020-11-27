import 'dart:math';
import 'package:tuple/tuple.dart';
// ported from https://github.com/adapap/whitespace-interpreter/blob/master/whitespace_interpreter.py#L1
// decoder https://naokikp.github.io/wsi/whitespace.html

class WhitespaceResult {
  final String output;
  final String code;
  final bool input_expected;
  final bool error;
  final String errorText;

  WhitespaceResult({
    this.output = '',
    this.code = '',
    this.input_expected = false,
    this.error = false,
    this.errorText = '',
  });
}

Future<WhitespaceResult> decodeWhitespace(String code, String inp, {int timeOut = 30000}) async {
  try {
    if (code == null || code.length == 0) return WhitespaceResult();

    _timeOut = max(timeOut, 100);

    code = code.toLowerCase();
    var codeWhite = _uncomment(code);
    var codeEnglish =
        code.replaceAll(RegExp(r'[^' + plainTextCharacterEnglish + ']'), '');
    var codeGerman =
        code.replaceAll(RegExp(r'[^' + plainTextCharacterGerman + ']'), '');

    if (codeWhite.length > codeEnglish.length &&
        codeWhite.length > codeGerman.length) {
      plainTextCharacter = plainTextCharacterEnglish;
      code = codeWhite;
    } else if (codeEnglish.length > codeWhite.length &&
        codeEnglish.length > codeGerman.length) {
      plainTextCharacter = plainTextCharacterEnglish;
      var result = await encodeWhitespace(codeEnglish);
      code = result.output;
    } else if (codeGerman.length > codeWhite.length &&
        codeGerman.length > codeEnglish.length) {
      plainTextCharacter = plainTextCharacterGerman;
      var result = await encodeWhitespace(codeGerman);
      code = result.output;
    } else
      code = codeWhite;

    var interpreter = _Interpreter(code, inp);
    interpreter.run();

    return WhitespaceResult(output: _output, input_expected: _input_required, code: _clean(_code));
  } catch (err) {
    return WhitespaceResult(
        output: _output,
        code: _clean(_code),
        input_expected: _input_required,
        error: true,
        errorText: err.toString() + (' (Position: ' + _pos.toString() + ')'));
  }
}

Future<WhitespaceResult> encodeWhitespace(String s) async {
  s = s.toLowerCase();
  s = s.replaceAll(RegExp(r'[^' + plainTextCharacter + ']'), '');
  s = s
      .replaceAll(plainTextCharacter[0], ' ')
      .replaceAll(plainTextCharacter[1], '\t')
      .replaceAll(plainTextCharacter[2], '\n');
  return WhitespaceResult(output: s);
}

/// Returns a readable string representation of whitespace.
String _clean(String s) {
  return s
      .replaceAll(' ', plainTextCharacter[0])
      .replaceAll('\t', plainTextCharacter[1])
      .replaceAll('\n', plainTextCharacter[2]);
}

List<String> _input;
var _stack = List<int>();
var _return_positions = List<int>();
var _heap = Map<int, int>();
var _labels = Map<String, int>();
var _pos = 0;
var _code = '';
var _code_length = 0;
var _inp = '';
var _output = '';
var _loading = true;
var _instruction = '';
var _command = '';
var _input_required = false;
var _debug = false;
var _timeOut = 30000;


const plainTextCharacterGerman = 'ltu';
const plainTextCharacterEnglish = 'stl';
var plainTextCharacter = plainTextCharacterEnglish;

/// The main interpreter for the program handles our state and responds to input.
class _Interpreter {
  DateTime start_time;

  /*Instruction Modification Parameters (IMPs)
  [space]: Stack Manipulation
  [tab][space]: Arithmetic
  [tab][tab]: Heap Access
  [tab][line-feed]: Input/Output
  [line-feed]: Flow Control
  */
  final Map<String, String> _IMP = {
    ' ': 'Stack',
    '\t ': 'Arithmetic',
    '\t\t': 'Heap',
    '\t\n': 'IO',
    '\n': 'FlowControl'
  };

  _Interpreter(String code, String inp) {
    _code = code;
    _code_length = _code.length;
    _inp = inp;
    _input = _inp.split('').toList();

    _stack.clear();
    _heap.clear();
    _pos = 0;
    _output = '';
    _loading = true;
    _instruction = '';
    _command = '';
    _labels.clear();
    _return_positions.clear();
    _input_required = false;
  }

  /// Main loop of the program goes through each instruction.
  void run() {
    if (_code_length == 0) {
      throw new Exception('SyntaxError: No program');
    }

    start_time = DateTime.now();

    while (_pos + 1 <= _code_length) {
      if ((DateTime.now().difference(start_time)).inMilliseconds > _timeOut) {
        throw new Exception('TimeOut: Program runs too long');
      }

      var token = _code.substring(_pos, _pos + 1);
      if (!_IMP.containsKey(token) && _pos + 2 <= _code.length) {
        token = _code.substring(_pos, _pos + 2);
      }
      // Check if our token is a valid IMP
      if (_IMP.containsKey(token)) {
        _instruction = _IMP[token];
      } else {
        if (!_loading)
          throw new Exception('Unknown instruction ' + _instruction);
      }

      _pos += token.length;
      switch (_instruction) {
        case 'Stack':
          _Stack().parse();
          break;
        case 'Arithmetic':
          _Arithmetic().parse();
          break;
        case 'Heap':
          _Heap().parse();
          break;
        case 'IO':
          _IO().parse();
          break;
        case 'FlowControl':
          _FlowControl().parse();
          break;
      }
      ;
    }
    if (_loading) {
      if (_debug) print('Finished marking labels. Starting program sequence...');
      _pos = 0;
      _loading = false;
      run();
    } else if ((_return_positions.length > 0) && (_pos != 9999999)) {
      if (!_loading)
        throw new Exception('SyntaxError: Subroutine does not properly exit or return');
    } else if (_pos == _code_length) {
      if (!_loading)
        throw new Exception('RuntimeError: Unclean termination');
    }
  }
}

/// Handles stack manipulation instructions.
class _Stack {
  /*Instructions
  [space] (number): Push n onto the stack.
  [tab][space] (number): Duplicate the nth value from the top of the stack.
  [tab][line-feed] (number): Discard the top n values below the top of the stack from the stack.
      (For n<0 or n>=stack.length, remove everything but the top value.)
  [line-feed][space]: Duplicate the top value on the stack.
  [line-feed][tab]: Swap the top two value on the stack.
  [line-feed][line-feed]: Discard the top value on the stack.
  */
  final Map<String, String> _STACK_IMP = {
    ' ': 'push_num',
    '\t ': 'duplicate_nth',
    '\t\n': 'discard_n',
    '\n ': 'duplicate_top',
    '\n\t': 'swap',
    '\n\n': 'discard_top'
  };

  /// Parses the next stack IMP.
  void parse() {
    _get_command(_STACK_IMP);

    if (_command == 'push_num') {
      var parameter = _num_parameter();
      var index = parameter.item1;
      var item = parameter.item2;
      if (!_loading) {
        _push_num(item);
      }
      _pos = index + 1;
    } else if (_command == 'duplicate_nth') {
      var parameter = _num_parameter();
      var index = parameter.item1;
      var item = parameter.item2;
      if (!_loading) {
        _debugOutput(_command, item.toString());
        _duplicate_nth(item);
      }
      _pos = index + 1;
    } else if (_command == 'discard_n') {
      var parameter = _num_parameter();
      var index = parameter.item1;
      var item = parameter.item2;
      if (!_loading) {
        _debugOutput(_command, item.toString());
        _discard_n(item);
      }
      _pos = index + 1;
    } else if (_command == 'duplicate_top') {
      if (!_loading) {
        _debugOutput(_command, null);
        _duplicate_nth(0);
      }
    } else if (_command == 'swap') {
      if (!_loading) {
        _debugOutput(_command, null);
        _swap();
      }
    } else if (_command == 'discard_top') {
      if (!_loading) {
        _debugOutput(_command, null);
        _discard_top();
      }
    }
  }

  void _push_num(int item) {
    _stack_append(item);
  }

  void _duplicate_nth(int n) {
    if (n > _stack.length - 1) {
      if (!_loading)
        Exception('ValueError: Cannot duplicate - Value exceeds stack size limit');
    } else if (n < 0) {
      if (!_loading)
        throw new Exception('IndexError: Cannot duplicate negative stack index');
    }
    var item = _stack[n]; //-n - 1
    _stack_append(item);
  }

  void _discard_n(int n) {
    if (n >= _stack.length || n < 0) {
      n = _stack.length - 1;
    }
    var top = _stack_pop();
    for (var i = 0; i < n; i++) {
      _stack_pop();
    }
    _stack_append(top);
  }

  void _discard_top() {
    _stack_pop();
  }

  void _swap() {
    var a = _stack_pop();
    var b = _stack_pop();
    _stack_append(a);
    _stack_append(b);
  }
}

///Handles input/output operations.
class _IO {
  /*Instructions
  [space][space]: Pop a value off the stack and output it as a character.
  [space][tab]: Pop a value off the stack and output it as a number.
  [tab][space]: Read a character from input, a, Pop a value off the stack, b, then store the ASCII value of a at heap address b.
  [tab][tab]: Read a number from input, a, Pop a value off the stack, b, then store a at heap address b.
  */
  final Map<String, String> _IO_IMP = {
    '  ': 'output_char',
    ' \t': 'output_num',
    '\t ': 'input_char',
    '\t\t': 'input_num'
  };

  /// Parses the next I/O IMP.
  void parse() {
    _get_command(_IO_IMP);
    if (_loading) {
      return;
    }
    _debugOutput(_command, null);
    if (_command == 'output_char') {
      _output_char();
    } else if (_command == 'output_num') {
      _output_num();
    } else if (_command == 'input_char') {
      _input_char();
    } else if (_command == 'input_num') {
      _input_num();
    }
  }

  void _output_char() {
    var char = new String.fromCharCode(_stack_pop());
    _output += char;
    _debugOutput('output char', char);
  }

  void _output_num() {
    var num = _stack_pop();
    _output += num.toString();
    _debugOutput('output num', num.toString());
  }

  void _input_char() {
    var a = _input_pop(0);
    var b = _stack_pop();
    _input_required = true;

    _heap.addAll({b: a.codeUnits[0]});
    _debugOutput('input_char', a);
  }

  void _input_num() {
    _input_required = true;
    var b = _stack_pop();
    var index = _input.indexOf('\n');
    if (index < 0) index = _input.indexOf(' ');
    if (index < 0) index = _input.length;
    if (index >= 0) {
      var num = _input.sublist(0, index).join();
      _input = _input.sublist(min(index + 1, _input.length - 1));

      _heap.addAll({b : int.parse(num)});
    }
  }

  String _input_pop(int index) {
    _input_required = true;
    var item = _input[index];
    _input.removeAt(index);
    return item;
  }
}

/// Handles flow control operations.
class _FlowControl {
  /*Instructions
  [space][space] (label): Mark a location in the program with label n.
  [space][tab] (label): Call a subroutine with the location specified by label n.
  [space][line-feed] (label): Jump unconditionally to the position specified by label n.
  [tab][space] (label): Pop a value off the stack and jump to the label specified by n if the value is zero.
  [tab][tab] (label): Pop a value off the stack and jump to the label specified by n if the value is less than zero.
  [tab][line-feed]: Exit a subroutine and return control to the location from which the subroutine was called.
  [line-feed][line-feed]: Exit the program.
  */
  final Map<String, String> _FLOW_IMP = {
    '  ': 'mark_label',
    ' \t': 'call_subroutine',
    ' \n': 'jump',
    '\t ': 'jump_zero',
    '\t\t': 'jump_lt_zero',
    '\t\n': 'exit_subroutine',
    '\n\n': 'exit'
  };

  ///Parses the next flow control IMP.
  void parse() {
    _get_command(_FLOW_IMP);
    if (_command == 'exit') {
      if (!_loading) {
        _debugOutput(_command, null);
        _exit();
      }
    } else if (_command == 'mark_label') {
      var parameter = _label_parameter();
      var index = parameter.item1;
      var label = parameter.item2;
      if (_loading) {
        _debugOutput(_command, _clean(label) + ' index:' + index.toString());
        _mark_label(label);
      } else {
        if (_debug) print('Ignoring label marker');
      }
      _pos = index;
    } else if (_command == 'jump') {
      var parameter = _label_parameter();
      var index = parameter.item1;
      var label = parameter.item2;
      if (!_loading) {
        _debugOutput(_command, _clean(label));
        _jump(label);
      } else {
        _pos = index;
      }
    } else if (_command == 'jump_zero') {
      var parameter = _label_parameter();
      var index = parameter.item1;
      var label = parameter.item2;
      if (!_loading) {
        _debugOutput(_command, _clean(label));
        var num = _stack_pop();
        if (num == 0) {
          _jump(label);
        } else {
          _pos = index;
        }
      } else {
        _pos = index;
      }
    } else if (_command == 'jump_lt_zero') {
      var parameter = _label_parameter();
      var index = parameter.item1;
      var label = parameter.item2;
      if (!_loading) {
        _debugOutput(_command, _clean(label));
        var num = _stack_pop();
        if (num < 0) {
          _jump(label);
        } else {
          _pos = index;
        }
      } else {
        _pos = index;
      }
    } else if (_command == 'exit_subroutine') {
      if (!_loading) {
        _debugOutput(_command, null);
        _exit_subroutine();
      }
    } else if (_command == 'call_subroutine') {
      var parameter = _label_parameter();
      var index = parameter.item1;
      var label = parameter.item2;
      _pos = index;
      if (!_loading) {
        _debugOutput(_command, _clean(label));
        _call_subroutine(label);
      }
    }
  }

  void _exit() {
    if (_debug) print('Program terminated.');
    _pos = 9999999;
  }

  void _mark_label(String label) {
    if (_labels.containsKey(label)) {
      if (!_loading)
        throw new Exception('ValueError: Label already exists');
    }
    _labels[label] = _pos + label.length;
  }

  void _jump(String label) {
    _pos = _labels[label];
  }

  void _exit_subroutine() {
    if (_return_positions.length > 0) {
      _pos = _return_positions_pop();
    } else {
      if (!_loading)
        throw new Exception('SyntaxError: Return outside of subroutine');
    }
  }

  void _call_subroutine(String label) {
    _return_positions_append(_pos);
    _pos = _labels[label];
  }

  void _return_positions_append(int item) {
    _return_positions.insert(0, item);
  }

  int _return_positions_pop() {
    var item = _return_positions.first;
    _return_positions.removeAt(0);
    return item;
  }
}

/// Handles arithmetic operations on the stack.
class _Arithmetic {
  /* Instructions
  [space][space]: Pop a and b, then push b+a.
  [space][tab]: Pop a and b, then push b-a.
  [space][line-feed]: Pop a and b, then push b*a.
  [tab][space]: Pop a and b, then push b/a*. If a is zero, throw an error.
  *Note that the result is defined as the floor of the quotient.
  [tab][tab]: Pop a and b, then push b%a*. If a is zero, throw an error.
  *Note that the result is defined as the remainder after division and sign (+/-) of the divisor (a).
  */
  final Map<String, String> _ARITHMETIC_IMP = {
    '  ': 'add',
    ' \t': 'sub',
    ' \n': 'mul',
    '\t ': 'floordiv',
    '\t\t': 'mod'
  };

  /// Parses the next arithmetic IMP.
  void parse() {
    _get_command(_ARITHMETIC_IMP);
    if (_loading) {
      return;
    } else if (_command == 'add') {
      _debugOutput(_command, null);
      add();
    } else if (_command == 'sub') {
      _debugOutput(_command, null);
      _sub();
    } else if (_command == 'mul') {
      _debugOutput(_command, null);
      _mul();
    } else if (_command == 'floordiv') {
      _debugOutput(_command, null);
      _floordiv();
    } else if (_command == 'mod') {
      _debugOutput(_command, null);
      _mod();
    }
  }

  void add() {
    var a = _stack_pop();
    var b = _stack_pop();
    var c = b + a;
    _stack_append(c);
  }

  void _sub() {
    var a = _stack_pop();
    var b = _stack_pop();
    var c = b - a;
    _stack_append(c);
  }

  void _mul() {
    var a = _stack_pop();
    var b = _stack_pop();
    var c = b * a;
    _stack_append(c);
  }

  void _floordiv() {
    var a = _stack_pop();
    var b = _stack_pop();
    if (a == 0)
      if (!_loading)
        throw new Exception('ZeroDivisionError: Cannot divide by zero');
      else
        a = 999999999999;
    var c = (b / a).floor();
    _stack_append(c);
  }

  void _mod() {
    var a = _stack_pop();
    var b = _stack_pop();
    if (a == 0)
      if (!_loading)
        throw new Exception('ZeroDivisionError: Cannot divide by zero');
      else
        a = 999999999999;
    var c = b % a;
    _stack_append(c);
  }
}

/// Handles operations on the heap.
class _Heap {
  /*Instructions
  [space]: Pop a and b, then store a at heap address b.
  [tab]: Pop a and then push the value at heap address a onto the stack.
  */
  final Map<String, String> _HEAP_IMP = {' ': 'store', '\t': 'push'};

  /// Parses the next heap IMP.
  void parse() {
    _get_command(_HEAP_IMP);
    if (_loading) return;
    if (_command == 'store') {
      _debugOutput(_command, null);
      _store();
    } else if (_command == 'push') {
      _debugOutput(_command, null);
      _push();
    }
  }

  void _store() {
    var a = _stack_pop();
    var b = _stack_pop();
    _heap[b] = a;
    _debugOutput('heap store', _heap[b].toString());
  }

  void _push() {
    var a = _stack_pop();
    _stack_append(_heap[a]);
    _debugOutput('heap push', _heap[a].toString());
  }
}



/// Removes extranneous characters from the code input.
String _uncomment(String s) {
  return s.replaceAll(RegExp(r'[^ \t\n]'), '');
}

void _stack_append(int item) {
  _debugOutput('stack append', item.toString());
  _stack.insert(0,item);
}

int _stack_pop() {
  if (_stack.length == 0) return null;
  var item = _stack.first;
  _stack.removeAt(0);
  _debugOutput('stack pop', item.toString());
  return item;
}

/// Gets the token for an IMP category.
void _get_command(Map<String, String> imp) {
  var token = '';
  if (_pos + 1 <= _code.length) {
    token = _code.substring(_pos, _pos + 1);
    if (!imp.containsKey(token) && _pos + 2 <= _code.length) {
      token = _code.substring(_pos, _pos + 2);
    }
  }
  // Check if our token is a valid IMP
  if (imp.containsKey(token)) {
    _command = imp[token];
    _pos += token.length;
  } else {
    if (!_loading)
      throw new Exception('KeyError: No IMP found for token: ' + token);
  }
}

/// Retrieves the next number in the sequence.
Tuple2<int, int> _num_parameter() {
  /*Format of a number:
  sign - binary - terminator
  sign: [space] + / [tab] -
  binary: [space] 0 / [tab] 1
  terminator: \n
  */
  var index = _code.indexOf('\n', _pos);
  // Only including a terminal causes an error
  if (index == _pos) {
    if (!_loading)
      Exception('SyntaxError: Number must include more than just the terminal.');
  }

  var item = _whitespaceToInt(_code.substring(_pos, index));
  return Tuple2<int, int>(index, item);
}

/// Converts the Whitespace representation of a number to an integer.
int _whitespaceToInt(String code) {
  var num = 0;
  if (code.length == 1) {
    num = 0;
    return num;
  }
  final List<String> keys = [' ', '\t'];
  var sign = 2 * (1 - keys.indexOf(code[0])) - 1;
  var binary = '';
  for (var x = 1; x < code.length; x++)
    binary += keys.indexOf(code[x]).toString();
  num = int.parse(binary, radix: 2) * sign;
  return num;
}

/// Sets a label in the sequence if possible.
Tuple2<int, String> _label_parameter() {
  /*Format of a label:
  name - terminator
  *name: any number of [space] and [tab]
  terminator: \n
  *Must be unique.
  */
  var index = _code.indexOf('\n', _pos) + 1;
  // Empty string is a valid label
  var name = _code.substring(_pos, index);
  return Tuple2<int, String>(index, name);
}


var counter = 1;
void _debugOutput(String command, String label) {
  if (_debug) {
    label = label != null ? ' (' + label + ')' : '';
    print('[' + counter.toString() + '] ' +
        'Command: ' +
        command +
        label);
    counter += 1;
  }
}
