// Define input validation errors

import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:maikol_tesis/generated/l10n.dart';

enum UserNameError { empty, format, size }

// Extend FormzInput and provide the input type and error type.
class Name extends FormzInput<String, UserNameError> {
  static final RegExp userNameRegExp = RegExp(
    // "^([a-zA-Z]{2,}\s[a-zA-Z]{1,}'?-?[a-zA-Z]{2,}\s?([a-zA-Z]{1,})?)",
    r'^[A-Za-zÀ-ÖØ-öø-ÿ -]+$',
  );

  // Call super.pure to represent an unmodified form input.
  const Name.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Name.dirty(super.value) : super.dirty();

  String? getErrorMessage(BuildContext context) {
    if (isValid || isPure) return null;

    if (displayError == UserNameError.empty)
      return S.of(context).validForm_campoRequerido;
    if (displayError == UserNameError.format)
      return S.of(context).validForm_NombreInvalido;
    if (displayError == UserNameError.size)
      return S.of(context).validForm_SizeName;

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  UserNameError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return UserNameError.empty;
    if (value.length < 3) return UserNameError.size;
    if (!userNameRegExp.hasMatch(value)) return UserNameError.format;

    return null;
  }
}
