// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, constant_identifier_names, non_constant_identifier_names,unnecessary_this

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String QuestionValueKey = 'question';

final Map<String, TextEditingController> _ChatViewTextEditingControllers = {};

final Map<String, FocusNode> _ChatViewFocusNodes = {};

final Map<String, String? Function(String?)?> _ChatViewTextValidations = {
  QuestionValueKey: null,
};

mixin $ChatView on StatelessWidget {
  TextEditingController get questionController =>
      _getFormTextEditingController(QuestionValueKey);
  FocusNode get questionFocusNode => _getFormFocusNode(QuestionValueKey);

  TextEditingController _getFormTextEditingController(String key,
      {String? initialValue}) {
    if (_ChatViewTextEditingControllers.containsKey(key)) {
      return _ChatViewTextEditingControllers[key]!;
    }
    _ChatViewTextEditingControllers[key] =
        TextEditingController(text: initialValue);
    return _ChatViewTextEditingControllers[key]!;
  }

  FocusNode _getFormFocusNode(String key) {
    if (_ChatViewFocusNodes.containsKey(key)) {
      return _ChatViewFocusNodes[key]!;
    }
    _ChatViewFocusNodes[key] = FocusNode();
    return _ChatViewFocusNodes[key]!;
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void syncFormWithViewModel(FormViewModel model) {
    questionController.addListener(() => _updateFormData(model));
  }

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  @Deprecated('Use syncFormWithViewModel instead.'
      'This feature was deprecated after 3.1.0.')
  void listenToFormUpdated(FormViewModel model) {
    questionController.addListener(() => _updateFormData(model));
  }

  final bool _autoTextFieldValidation = true;
  bool validateFormFields(FormViewModel model) {
    _updateFormData(model, forceValidate: true);
    return model.isFormValid;
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model, {bool forceValidate = false}) {
    model.setData(
      model.formValueMap
        ..addAll({
          QuestionValueKey: questionController.text,
        }),
    );
    if (_autoTextFieldValidation || forceValidate) {
      _updateValidationData(model);
    }
  }

  /// Updates the fieldsValidationMessages on the FormViewModel
  void _updateValidationData(FormViewModel model) =>
      model.setValidationMessages({
        QuestionValueKey: _getValidationMessage(QuestionValueKey),
      });

  /// Returns the validation message for the given key
  String? _getValidationMessage(String key) {
    final validatorForKey = _ChatViewTextValidations[key];
    if (validatorForKey == null) return null;
    String? validationMessageForKey =
        validatorForKey(_ChatViewTextEditingControllers[key]!.text);
    return validationMessageForKey;
  }

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    for (var controller in _ChatViewTextEditingControllers.values) {
      controller.dispose();
    }
    for (var focusNode in _ChatViewFocusNodes.values) {
      focusNode.dispose();
    }

    _ChatViewTextEditingControllers.clear();
    _ChatViewFocusNodes.clear();
  }
}

extension ValueProperties on FormViewModel {
  bool get isFormValid =>
      this.fieldsValidationMessages.values.every((element) => element == null);
  String? get questionValue => this.formValueMap[QuestionValueKey] as String?;

  set questionValue(String? value) {
    this.setData(
      this.formValueMap
        ..addAll({
          QuestionValueKey: value,
        }),
    );

    if (_ChatViewTextEditingControllers.containsKey(QuestionValueKey)) {
      _ChatViewTextEditingControllers[QuestionValueKey]?.text = value ?? '';
    }
  }

  bool get hasQuestion =>
      this.formValueMap.containsKey(QuestionValueKey) &&
      (questionValue?.isNotEmpty ?? false);

  bool get hasQuestionValidationMessage =>
      this.fieldsValidationMessages[QuestionValueKey]?.isNotEmpty ?? false;

  String? get questionValidationMessage =>
      this.fieldsValidationMessages[QuestionValueKey];
  void clearForm() {
    questionValue = '';
  }
}

extension Methods on FormViewModel {
  setQuestionValidationMessage(String? validationMessage) =>
      this.fieldsValidationMessages[QuestionValueKey] = validationMessage;
}
