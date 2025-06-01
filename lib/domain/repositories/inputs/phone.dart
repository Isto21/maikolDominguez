// Define input validation errors

import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:maikol_tesis/generated/l10n.dart';

enum PhoneError { empty, format, size }

// Extend FormzInput and provide the input type and error type.
class Phone extends FormzInput<String, PhoneError> {
  // static final RegExp mobilePhoneRegExp = RegExp(r'^5[0-9]{7}$');
  // static final RegExp phoneRegExp = RegExp(r'^[1-4][0-9]{5,7}$');

  // Call super.pure to represent an unmodified form input.
  const Phone.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Phone.dirty(super.value) : super.dirty();

  String? getErrorMessage(BuildContext context) {
    if (isValid || isPure) return null;

    if (displayError == PhoneError.empty) {
      return S.of(context).validForm_campoRequerido;
    }
    // if (displayError == PhoneError.format)
    // return S.of(context).validForm_NumeroInvalido;
    if (displayError == PhoneError.size) {
      return S.of(context).validForm_SizeFormat;
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PhoneError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return PhoneError.empty;
    if (value.length <= 3) return PhoneError.size;
    // if (!phoneRegExp.hasMatch(value) && !mobilePhoneRegExp.hasMatch(value)) {
    // return PhoneError.format;
    // }

    return null;
  }
}
