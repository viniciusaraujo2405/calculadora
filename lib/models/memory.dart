import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Memory {
  static const operations = const ['%', '/', 'x', '-', '+', '=', '^'];
  final _buffer = [0.0, 0.0];
  int _bufferIndex = 0;
  String? _operation ;
  String _value = '0';
  bool _wipeValue = false;
  String _lastCommand = '';
 
  


  void applyCommand(String command) {
    if(_isReplacingOperation(command)) {
      _operation = command;
      return;
    }
    if(command  == 'AC') {
      _allClear();
    } else if (operations.contains(command)) {
      _setOperation(command);
    } else {
      _addDigit(command);
    }
    _lastCommand = command;
  }

  _isReplacingOperation(String command) {
    return operations.contains(_lastCommand) && operations.contains(command) && _lastCommand != '=' && command != '=';
  }

  _setOperation(String newOperation){
    bool isEqualSign = newOperation == '=';
    if(_bufferIndex == 0) {
      if(!isEqualSign) {
        _operation = newOperation;
        _bufferIndex = 1;
        _wipeValue = true;
                          }
      } else {
      final firstOperand = _buffer[0];
      final secondOperand = _buffer[1];
      final operation = _operation;
      _buffer[0] = _calculate();
      _buffer[1] = 0.0;
      _value = _buffer[0].toString();
      _value = _value.endsWith('.0') ? _value.split('.')[0] : _value;

      if (isEqualSign && operation != null) {
      _saveToFirestore(firstOperand, secondOperand, operation, _buffer[0]);
    }
      
      _operation = isEqualSign ? null : newOperation; 
      _bufferIndex = isEqualSign ? 0 : 1;
      _wipeValue = true;
    }

  }

  _addDigit(String digit) {
  final isDot = digit == '.';
  final wipeValue = (_value == '0' && !isDot) || _wipeValue;

  if (isDot && _value.contains('.') && !wipeValue) {
    return;
  }

  final currentValue = wipeValue ? '' : _value;
  _value = currentValue + digit;
  _wipeValue = false; 

  _buffer[_bufferIndex] = double.tryParse(_value) ?? 0;
}

  void _allClear () {
    _value = '0';
    _buffer.setAll(0, [0.0, 0.0]);
    _bufferIndex = 0;
    _operation = null;
    _wipeValue = false;
  }

  _calculate () {
    switch(_operation) {
      case '%': return _buffer[0] % _buffer[1];
      case '/': return _buffer[0] / _buffer[1];
      case 'x': return _buffer[0] * _buffer[1];
      case '-': return _buffer[0] - _buffer[1];
      case '+': return _buffer[0] + _buffer[1];
      case '^':  return pow(_buffer[0], _buffer[1]);
      default: return _buffer[0];
    }
  }

  void _saveToFirestore(double firstOperand, double secondOperand, String operation, double result) {
     final user = FirebaseAuth.instance.currentUser;

     if(user != null) {
       FirebaseFirestore.instance.collection('operations').add({
          'expression': '$firstOperand $_operation $secondOperand',
          'result': result,
          'timestamp': FieldValue.serverTimestamp(),
          'userId': user.uid
        });
        }
      }
  String get value {
    return _value;
  }	
}