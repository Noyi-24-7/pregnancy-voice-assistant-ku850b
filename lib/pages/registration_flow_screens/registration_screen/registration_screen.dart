import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreenWidget extends StatefulWidget {
  const RegistrationScreenWidget({super.key});

  static const String routeName = 'RegistrationScreen';
  static const String routePath = '/registrationScreen';

  @override
  State<RegistrationScreenWidget> createState() =>
      _RegistrationScreenWidgetState();
}

class _RegistrationScreenWidgetState extends State<RegistrationScreenWidget> {
  late TextEditingController _nameTextController;
  late FocusNode _nameFocusNode;
  String? Function(BuildContext, String?)? _nameTextControllerValidator;
  late TextEditingController _ageTextController;
  late FocusNode _ageFocusNode;
  String? Function(BuildContext, String?)? _ageTextControllerValidator;
  String? _genderValue;
  FormFieldController<String>? _genderValueController;
  String? _languageValue = 'en';
  FormFieldController<String>? _languageValueController;
  String? _stateValue;
  FormFieldController<String>? _stateValueController;
  String? _lgaValue;
  FormFieldController<String>? _lgaValueController;
  bool? saveProfileData;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _nameFocusNode = FocusNode();
    _ageTextController = TextEditingController();
    _ageFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _nameTextController.dispose();
    _ageFocusNode.dispose();
    _ageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 56.0, 16.0, 0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'TELL US ABOUT YOURSELF',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Clash Grotesk',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            _RegistrationFormSection(
                              nameTextController: _nameTextController,
                              nameFocusNode: _nameFocusNode,
                              nameTextControllerValidator:
                                  _nameTextControllerValidator,
                              ageTextController: _ageTextController,
                              ageFocusNode: _ageFocusNode,
                              ageTextControllerValidator:
                                  _ageTextControllerValidator,
                              genderValue: _genderValue,
                              genderValueController: _genderValueController,
                              onGenderChanged: (val) {
                                setState(() {
                                  _genderValue = val;
                                });
                              },
                              languageValue: _languageValue,
                              languageValueController: _languageValueController,
                              onLanguageChanged: (val) {
                                setState(() {
                                  _languageValue = val;
                                });
                              },
                              stateValue: _stateValue,
                              stateValueController: _stateValueController,
                              onStateChanged: (val) {
                                setState(() {
                                  _stateValue = val;
                                });
                              },
                              lgaValue: _lgaValue,
                              lgaValueController: _lgaValueController,
                              onLgaChanged: (val) {
                                setState(() {
                                  _lgaValue = val;
                                });
                              },
                            ),
                          ]
                              .divide(const SizedBox(height: 40.0))
                              .addToEnd(const SizedBox(height: 200.0)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 1.0),
                      child: _ButtonSection(
                        onSave: () async {
                          saveProfileData = await actions.saveProfileData(
                            _nameTextController.text,
                            int.parse(_ageTextController.text),
                            _genderValue ?? '',
                            _languageValue ?? 'en',
                            _stateValue ?? '',
                            _lgaValue ?? '',
                          );
                          if (saveProfileData == true) {
                            context.pushNamed(
                              MedicalHistoryScreenWidget.routeName,
                              extra: <String, dynamic>{
                                kTransitionInfoKey: TransitionInfo(
                                  hasTransition: true,
                                  transitionType:
                                      PageTransitionType.rightToLeft,
                                ),
                              },
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Failed to save profile data',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Gilroy',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                                duration: const Duration(milliseconds: 4000),
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .micContainerBackground,
                              ),
                            );
                          }

                          if (mounted) {
                            setState(() {});
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegistrationFormSection extends StatelessWidget {
  const _RegistrationFormSection({
    required this.nameTextController,
    required this.nameFocusNode,
    this.nameTextControllerValidator,
    required this.ageTextController,
    required this.ageFocusNode,
    this.ageTextControllerValidator,
    required this.genderValue,
    required this.genderValueController,
    required this.onGenderChanged,
    required this.languageValue,
    required this.languageValueController,
    required this.onLanguageChanged,
    required this.stateValue,
    required this.stateValueController,
    required this.onStateChanged,
    required this.lgaValue,
    required this.lgaValueController,
    required this.onLgaChanged,
  });

  final TextEditingController nameTextController;
  final FocusNode nameFocusNode;
  final String? Function(BuildContext, String?)? nameTextControllerValidator;
  final TextEditingController ageTextController;
  final FocusNode ageFocusNode;
  final String? Function(BuildContext, String?)? ageTextControllerValidator;
  final String? genderValue;
  final FormFieldController<String>? genderValueController;
  final ValueChanged<String?> onGenderChanged;
  final String? languageValue;
  final FormFieldController<String>? languageValueController;
  final ValueChanged<String?> onLanguageChanged;
  final String? stateValue;
  final FormFieldController<String>? stateValueController;
  final ValueChanged<String?> onStateChanged;
  final String? lgaValue;
  final FormFieldController<String>? lgaValueController;
  final ValueChanged<String?> onLgaChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _NameField(
          controller: nameTextController,
          focusNode: nameFocusNode,
          validator: nameTextControllerValidator,
        ),
        _AgeField(
          controller: ageTextController,
          focusNode: ageFocusNode,
          validator: ageTextControllerValidator,
        ),
        _GenderField(
          value: genderValue,
          controller: genderValueController,
          onChanged: onGenderChanged,
        ),
        _LanguageField(
          value: languageValue,
          controller: languageValueController,
          onChanged: onLanguageChanged,
        ),
        _StateField(
          value: stateValue,
          controller: stateValueController,
          onChanged: onStateChanged,
        ),
        _LgaField(
          value: lgaValue,
          controller: lgaValueController,
          onChanged: onLgaChanged,
        ),
      ].divide(const SizedBox(height: 24.0)),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField({
    required this.controller,
    required this.focusNode,
    this.validator,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(BuildContext, String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Name',
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
                lineHeight: 1.5,
              ),
        ),
        Container(
          width: double.infinity,
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            autofocus: false,
            obscureText: false,
            decoration: InputDecoration(
              isDense: false,
              labelStyle:
                  FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.0,
                        lineHeight: 1.5,
                      ),
              hintText: 'Enter your full name',
              hintStyle:
                  FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.0,
                        lineHeight: 1.5,
                      ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0x00000000),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0x00000000),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor:
                  FlutterFlowTheme.of(context).secondaryBackground,
              contentPadding: const EdgeInsetsDirectional.fromSTEB(
                  12.0, 12.0, 12.0, 12.0),
            ),
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'Gilroy',
                  letterSpacing: 0.0,
                  lineHeight: 1.5,
                ),
            cursorColor: FlutterFlowTheme.of(context).primaryText,
            enableInteractiveSelection: true,
            validator: validator?.asValidator(context),
          ),
        ),
      ].divide(const SizedBox(height: 8.0)),
    );
  }
}

class _AgeField extends StatelessWidget {
  const _AgeField({
    required this.controller,
    required this.focusNode,
    this.validator,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(BuildContext, String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Age',
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
                lineHeight: 1.5,
              ),
        ),
        Container(
          width: double.infinity,
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            autofocus: false,
            obscureText: false,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              isDense: false,
              labelStyle:
                  FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.0,
                        lineHeight: 1.5,
                      ),
              hintText: 'Enter your age',
              hintStyle:
                  FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.0,
                        lineHeight: 1.5,
                      ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0x00000000),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0x00000000),
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              filled: true,
              fillColor:
                  FlutterFlowTheme.of(context).secondaryBackground,
              contentPadding: const EdgeInsetsDirectional.fromSTEB(
                  12.0, 12.0, 12.0, 12.0),
            ),
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'Gilroy',
                  letterSpacing: 0.0,
                  lineHeight: 1.5,
                ),
            cursorColor: FlutterFlowTheme.of(context).primaryText,
            enableInteractiveSelection: true,
            validator: validator?.asValidator(context),
          ),
        ),
      ].divide(const SizedBox(height: 8.0)),
    );
  }
}

class _GenderField extends StatelessWidget {
  const _GenderField({
    required this.value,
    required this.controller,
    required this.onChanged,
  });

  final String? value;
  final FormFieldController<String>? controller;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
                lineHeight: 1.5,
              ),
        ),
        FlutterFlowDropDown<String>(
          controller: controller ?? FormFieldController<String>(null),
          options: const [
            'Male',
            'Female',
            'Other',
            'Prefer not to say'
          ],
          onChanged: onChanged,
          width: double.infinity,
          height: 48.0,
          textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
              ),
          hintText: 'Select gender',
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 24.0,
          ),
          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 2.0,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 8.0,
          margin: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
          hidesUnderline: true,
          isOverButton: false,
          isSearchable: false,
          isMultiSelect: false,
        ),
      ].divide(const SizedBox(height: 8.0)),
    );
  }
}

class _LanguageField extends StatelessWidget {
  const _LanguageField({
    required this.value,
    required this.controller,
    required this.onChanged,
  });

  final String? value;
  final FormFieldController<String>? controller;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferred Language',
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
                lineHeight: 1.5,
              ),
        ),
        FlutterFlowDropDown<String>(
          controller: controller ??
              FormFieldController<String>(value ?? 'en'),
          options: const ['en', 'yo', 'ig', 'ha'],
          optionLabels: const [
            'English',
            'Yoruba',
            'Igbo',
            'Hausa'
          ],
          onChanged: onChanged,
          width: double.infinity,
          height: 48.0,
          textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
              ),
          hintText: 'Select Language',
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 24.0,
          ),
          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 2.0,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 8.0,
          margin: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
          hidesUnderline: true,
          isOverButton: false,
          isSearchable: false,
          isMultiSelect: false,
        ),
      ].divide(const SizedBox(height: 8.0)),
    );
  }
}

class _StateField extends StatelessWidget {
  const _StateField({
    required this.value,
    required this.controller,
    required this.onChanged,
  });

  final String? value;
  final FormFieldController<String>? controller;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'State',
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
                lineHeight: 1.5,
              ),
        ),
        FlutterFlowDropDown<String>(
          controller: controller ?? FormFieldController<String>(null),
          options: const [
            'Lagos',
            'Kano',
            'Rivers',
            'Oyo'
          ],
          onChanged: onChanged,
          width: double.infinity,
          height: 48.0,
          textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
              ),
          hintText: 'Select state',
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 24.0,
          ),
          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 2.0,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 8.0,
          margin: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
          hidesUnderline: true,
          isOverButton: false,
          isSearchable: false,
          isMultiSelect: false,
        ),
      ].divide(const SizedBox(height: 8.0)),
    );
  }
}

class _LgaField extends StatelessWidget {
  const _LgaField({
    required this.value,
    required this.controller,
    required this.onChanged,
  });

  final String? value;
  final FormFieldController<String>? controller;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Local Government Area',
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
                lineHeight: 1.5,
              ),
        ),
        FlutterFlowDropDown<String>(
          controller: controller ?? FormFieldController<String>(null),
          options: const [
            'Ikeja',
            'Victoria Island',
            'Lekki',
            'Surulere',
            'Alimosho',
            'Kano Municipal',
            'Port Harcourt',
            'Ibadan North'
          ],
          onChanged: onChanged,
          width: double.infinity,
          height: 48.0,
          textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
              ),
          hintText: 'Select LGA',
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 24.0,
          ),
          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 2.0,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 8.0,
          margin: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
          hidesUnderline: true,
          isOverButton: false,
          isSearchable: false,
          isMultiSelect: false,
        ),
      ].divide(const SizedBox(height: 8.0)),
    );
  }
}

class _ButtonSection extends StatelessWidget {
  const _ButtonSection({required this.onSave});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        border: Border.all(
          color: FlutterFlowTheme.of(context).micStroke,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FFButtonWidget(
              onPressed: () async {
                context.safePop();
              },
              text: 'BACK',
              options: FFButtonOptions(
                width: double.infinity,
                height: 43.0,
                padding: const EdgeInsetsDirectional.fromSTEB(
                    16.0, 0.0, 16.0, 0.0),
                iconPadding: EdgeInsetsDirectional.zero,
                color: FlutterFlowTheme.of(context).accent4,
                textStyle:
                    FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Clash Grotesk',
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          lineHeight: 1.2,
                        ),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            FFButtonWidget(
              onPressed: onSave,
              text: 'VERIFY & CONTINUE',
              options: FFButtonOptions(
                width: double.infinity,
                height: 43.0,
                padding: const EdgeInsetsDirectional.fromSTEB(
                    16.0, 0.0, 16.0, 0.0),
                iconPadding: EdgeInsetsDirectional.zero,
                color: FlutterFlowTheme.of(context).primary,
                textStyle:
                    FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Clash Grotesk',
                          color: FlutterFlowTheme.of(context).info,
                          letterSpacing: 0.0,
                          lineHeight: 1.2,
                        ),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ].divide(const SizedBox(height: 8.0)),
        ),
      ),
    );
  }
}

