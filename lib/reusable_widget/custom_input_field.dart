// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class DropdownModel {
  String value;
  String item;

  DropdownModel({required this.item, required this.value});
}

class CustomInputField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final TextInputType inputType;
  final FormFieldValidator<String>? validator;
  final bool isPassword;
  final bool isPhone;
  final bool isEmail;
  final bool isRequired;
  final bool isDropdown;
  final bool isCheckbox;
  final List<DropdownModel>? dropdownItems;
  final ValueChanged<bool>? onCheckboxChanged;
  final ValueChanged<String?>? onDropdownChanged;
  final String? fieldName; // Add this for the field name

  CustomInputField({
    required this.label,
    this.controller,
    this.inputType = TextInputType.text,
    this.validator,
    this.isPassword = false,
    this.isPhone = false,
    this.isEmail = false,
    this.isRequired = false,
    this.isDropdown = false,
    this.isCheckbox = false,
    this.dropdownItems,
    this.onCheckboxChanged,
    this.onDropdownChanged,
    this.fieldName,
  });

  String? phoneNumberValidator(String? value, bool isRequired) {
    if (isRequired) {
      if (value == null || value.isEmpty) {
        return 'Phone number is required';
      }
      final phoneRegExp = RegExp(r'^[+]?[0-9]{10,15}$');
      if (!phoneRegExp.hasMatch(value)) {
        return 'Please enter a valid phone number';
      }
    } else {
      if (value != null && value.isNotEmpty) {
        final phoneRegExp = RegExp(r'^[+]?[0-9]{10,15}$');
        if (!phoneRegExp.hasMatch(value)) {
          return 'Please enter a valid phone number';
        }
      }
    }
    return null;
  }

  String? emailValidator(String? value, bool isRequired) {
    if (isRequired) {
      if (value == null || value.isEmpty) {
        return 'Email is required';
      }
      final emailRegExp =
          RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
      if (!emailRegExp.hasMatch(value)) {
        return 'Please enter a valid email address';
      }
    } else {
      if (value != null && value.isNotEmpty) {
        final emailRegExp =
            RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
        if (!emailRegExp.hasMatch(value)) {
          return 'Please enter a valid email address';
        }
      }
    }
    return null;
  }

  String? passwordValidator(String? value, bool isRequired) {
    if (isRequired) {
      if (value == null || value.isEmpty) {
        return 'Password is required';
      }
      if (value.length < 8) {
        return 'Password must be at least 8 characters';
      }
      if (!RegExp(r'\d').hasMatch(value)) {
        return 'Password must contain at least one digit';
      }
    } else {
      if (value != null && value.isNotEmpty) {
        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }
        if (!RegExp(r'\d').hasMatch(value)) {
          return 'Password must contain at least one digit';
        }
      }
    }
    return null;
  }

  String? requiredValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (isDropdown) {
      return _buildDropdown();
    } else if (isCheckbox) {
      return _buildCheckbox();
    } else {
      return _buildTextField(context);
    }
  }

  Widget _buildTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blueAccent),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
        ),
        validator: (value) {
          if (isPassword) {
            return passwordValidator(value, isRequired);
          }
          if (isPhone) {
            return phoneNumberValidator(value, isRequired);
          }
          if (isEmail) {
            return emailValidator(value, isRequired);
          }
          if (isRequired) {
            return requiredValidator(value);
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: DropdownButtonFormField<String?>(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.blueAccent),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.blue, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey, width: 1.5),
          ),
        ),
        value: null,
        items: dropdownItems?.map((item) {
          return DropdownMenuItem<String?>(
            value: item.value,
            child: Text(item.item),
          );
        }).toList(),
        onChanged: (newValue) {
          if (newValue != null) {
            controller?.text = newValue;
          }
          if (onDropdownChanged != null) {
            onDropdownChanged!(newValue);
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select an option';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCheckbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: CheckboxListTile(
        title: Text(label),
        value: controller?.text == 'true',
        activeColor: Colors.blueAccent,
        onChanged: (bool? value) {
          if (onCheckboxChanged != null) {
            onCheckboxChanged!(value ?? false);
          }
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
