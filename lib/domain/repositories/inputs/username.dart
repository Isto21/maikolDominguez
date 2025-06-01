// Define input validation errors

import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:maikol_tesis/generated/l10n.dart';

enum AliasError { empty, format, size }

// Extend FormzInput and provide the input type and error type.
class Username extends FormzInput<String, AliasError> {
  // static final RegExp userNameRegExp = RegExp(r'^[a-zA-Z0-9]+$');
  static final RegExp userNameRegExp = RegExp(r'^[\w\._]+$');
  // Call super.pure to represent an unmodified form input.
  const Username.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Username.dirty(super.value) : super.dirty();

  String? getErrorMessage(BuildContext context) {
    if (isValid || isPure) return null;

    if (displayError == AliasError.empty) {
      return S.of(context).validForm_campoRequerido;
    }
    if (displayError == AliasError.format) {
      return S.of(context).validForm_NombreInvalido;
    }
    if (displayError == AliasError.size) {
      return S.of(context).validForm_SizeName;
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  AliasError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return AliasError.empty;
    if (value.length < 3) return AliasError.size;
    if (!userNameRegExp.hasMatch(value)) return AliasError.format;

    return null;
  }
}
