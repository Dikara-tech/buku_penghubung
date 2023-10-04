import 'package:flutter/widgets.dart';

class GoValidator {
  final BuildContext context;

  const GoValidator._(this.context);

  static GoValidator of(BuildContext context) => GoValidator._(context);

  String? emailOrPhone(String? value) {
    final text = value ?? '';
    final phoneReg = RegExp(r'^-?\d+$');
    if (phoneReg.hasMatch(text)) {
      if (text.length < 8) {
        return 'No. HP Minimal 8 digit';
      }
      if (text.length > 15) {
        return 'No. HP terlalu panjang, maksimum 15 angka';
      }
    } else {
      final emailRegex = RegExp(
        r"^[a-zA-Z\da-zA-Z.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d-]+\.[a-zA-Z]+",
      );
      if (!emailRegex.hasMatch(text)) {
        return 'Format email salah';
      }
    }

    return null;
  }

  String? email(String? value) {
    const pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(value ?? '')) {
      return 'Format email salah';
    } else {
      return null;
    }
  }

  String? minLength(String? value, int length) {
    if (value?.isNotEmpty == true) {
      if (value!.length < length) {
        return 'mininmal length is $length';
      }
    }

    return null;
  }

  String? required(String? value, {String? fieldName}) {
    if (value?.isEmpty ?? true) {
      return 'This field is required';
    } else {
      return null;
    }
  }

  String? phoneNumber(String? value) {
    if (value?.isNotEmpty == true) {
      const pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
      final regExp = RegExp(pattern);

      if (value!.length < 8) {
        if (!regExp.hasMatch(value)) {
          return 'Format nomor salah';
        }
        return 'Nomor ponsel terlalu pendek, minimum 8 angka';
      }
    }

    return null;
  }
}
