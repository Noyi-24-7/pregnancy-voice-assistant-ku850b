import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfileScreenWidget extends StatefulWidget {
  const EditProfileScreenWidget({super.key});

  static const String routeName = 'EditProfileScreen';
  static const String routePath = '/editProfileScreen';

  @override
  State<EditProfileScreenWidget> createState() =>
      _EditProfileScreenWidgetState();
}

class _EditProfileScreenWidgetState extends State<EditProfileScreenWidget> {
  late TextEditingController _nameTextController;
  late FocusNode _nameFocusNode;
  String? Function(BuildContext, String?)? _nameTextControllerValidator;
  late TextEditingController _ageTextController;
  late FocusNode _ageFocusNode;
  String? Function(BuildContext, String?)? _ageTextControllerValidator;
  String? _genderValue;
  FormFieldController<String>? _genderValueController;
  String? _languageValue;
  FormFieldController<String>? _languageValueController;
  late TextEditingController _allergiesTextController;
  late FocusNode _allergiesFocusNode;
  String? Function(BuildContext, String?)? _allergiesTextControllerValidator;
  late TextEditingController _medicationsTextController;
  late FocusNode _medicationsFocusNode;
  String? Function(BuildContext, String?)? _medicationsTextControllerValidator;
  late TextEditingController _conditionsTextController;
  late FocusNode _conditionsFocusNode;
  String? Function(BuildContext, String?)? _conditionsTextControllerValidator;
  String? _bloodTypeValue;
  FormFieldController<String>? _bloodTypeValueController;
  String? _stateValue;
  FormFieldController<String>? _stateValueController;
  String? _lgaValue;
  FormFieldController<String>? _lgaValueController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController(
      text: getJsonField(
        FFAppState().currentPatientData,
        r'''$.profile.name''',
      ).toString(),
    );
    _nameFocusNode = FocusNode();
    _ageTextController = TextEditingController(
      text: getJsonField(
        FFAppState().currentPatientData,
        r'''$.profile.age''',
      ).toString(),
    );
    _ageFocusNode = FocusNode();
    _allergiesTextController = TextEditingController(
      text: getJsonField(
        FFAppState().currentPatientData,
        r'''$.medical.allergies''',
      ).toString(),
    );
    _allergiesFocusNode = FocusNode();
    _medicationsTextController = TextEditingController(
      text: getJsonField(
        FFAppState().currentPatientData,
        r'''$.medical.currentMedications''',
      ).toString(),
    );
    _medicationsFocusNode = FocusNode();
    _conditionsTextController = TextEditingController(
      text: getJsonField(
        FFAppState().currentPatientData,
        r'''$.medical.chronicConditions''',
      ).toString(),
    );
    _conditionsFocusNode = FocusNode();
    _genderValue = getJsonField(
      FFAppState().currentPatientData,
      r'''$.profile.gender''',
    ).toString();
    _bloodTypeValue = valueOrDefault<String>(
      getJsonField(
        FFAppState().currentPatientData,
        r'''$.medical.bloodType''',
      )?.toString(),
      'O+',
    );
    _stateValue = getJsonField(
      FFAppState().currentPatientData,
      r'''$.profile.location.state''',
    ).toString();
    _lgaValue = getJsonField(
      FFAppState().currentPatientData,
      r'''$.profile.location.lga''',
    ).toString();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _nameTextController.dispose();
    _ageFocusNode.dispose();
    _ageTextController.dispose();
    _allergiesFocusNode.dispose();
    _allergiesTextController.dispose();
    _medicationsFocusNode.dispose();
    _medicationsTextController.dispose();
    _conditionsFocusNode.dispose();
    _conditionsTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _HeaderSection(),
              Flexible(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          16.0, 0.0, 16.0, 0.0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            _PersonalInformationSection(
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
                            ),
                            _MedicalInformationSection(
                              allergiesTextController: _allergiesTextController,
                              allergiesFocusNode: _allergiesFocusNode,
                              allergiesTextControllerValidator:
                                  _allergiesTextControllerValidator,
                              medicationsTextController:
                                  _medicationsTextController,
                              medicationsFocusNode: _medicationsFocusNode,
                              medicationsTextControllerValidator:
                                  _medicationsTextControllerValidator,
                              conditionsTextController:
                                  _conditionsTextController,
                              conditionsFocusNode: _conditionsFocusNode,
                              conditionsTextControllerValidator:
                                  _conditionsTextControllerValidator,
                              bloodTypeValue: _bloodTypeValue,
                              bloodTypeValueController: _bloodTypeValueController,
                              onBloodTypeChanged: (val) {
                                setState(() {
                                  _bloodTypeValue = val;
                                });
                              },
                            ),
                            _LocationInformationSection(
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
                              .divide(const SizedBox(height: 16.0))
                              .addToEnd(const SizedBox(height: 120.0)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(-1.0, 1.0),
                      child: _SaveButtonSection(
                        onSave: () async {
                          await actions.updatePatientProfile(
                            _nameTextController.text,
                            int.parse(_ageTextController.text),
                            _genderValue ?? '',
                            _languageValue ?? '',
                            _stateValue ?? '',
                            _lgaValue ?? '',
                            _allergiesTextController.text,
                            _medicationsTextController.text,
                            _conditionsTextController.text,
                            _bloodTypeValue ?? 'Unknown',
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ].divide(const SizedBox(height: 24.0)),
          ),
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primary,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.safePop();
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.chevron_left_rounded,
                    color: FlutterFlowTheme.of(context).info,
                    size: 24.0,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Profile',
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              fontFamily: 'Gilroy',
                              letterSpacing: 0.0,
                              lineHeight: 1.3,
                            ),
                      ),
                      Text(
                        'Update Your Information',
                        style: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily: 'Gilroy',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ].divide(const SizedBox(height: 4.0)),
                  ),
                ].divide(const SizedBox(width: 8.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PersonalInformationSection extends StatelessWidget {
  const _PersonalInformationSection({
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).micContainerBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).accent4,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PERSONAL INFORMATION',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Clash Grotesk',
                    letterSpacing: 0.0,
                    lineHeight: 1.5,
                  ),
            ),
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
          ].divide(const SizedBox(height: 24.0)),
        ),
      ),
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
          controller: controller ??
              FormFieldController<String>(value),
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
          controller: controller ?? FormFieldController<String>(value ?? ''),
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

class _MedicalInformationSection extends StatelessWidget {
  const _MedicalInformationSection({
    required this.allergiesTextController,
    required this.allergiesFocusNode,
    this.allergiesTextControllerValidator,
    required this.medicationsTextController,
    required this.medicationsFocusNode,
    this.medicationsTextControllerValidator,
    required this.conditionsTextController,
    required this.conditionsFocusNode,
    this.conditionsTextControllerValidator,
    required this.bloodTypeValue,
    required this.bloodTypeValueController,
    required this.onBloodTypeChanged,
  });

  final TextEditingController allergiesTextController;
  final FocusNode allergiesFocusNode;
  final String? Function(BuildContext, String?)?
      allergiesTextControllerValidator;
  final TextEditingController medicationsTextController;
  final FocusNode medicationsFocusNode;
  final String? Function(BuildContext, String?)?
      medicationsTextControllerValidator;
  final TextEditingController conditionsTextController;
  final FocusNode conditionsFocusNode;
  final String? Function(BuildContext, String?)?
      conditionsTextControllerValidator;
  final String? bloodTypeValue;
  final FormFieldController<String>? bloodTypeValueController;
  final ValueChanged<String?> onBloodTypeChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).micContainerBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).accent4,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'MEDICAL INFORMATION',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Clash Grotesk',
                    letterSpacing: 0.0,
                    lineHeight: 1.5,
                  ),
            ),
            _AllergiesField(
              controller: allergiesTextController,
              focusNode: allergiesFocusNode,
              validator: allergiesTextControllerValidator,
            ),
            _MedicationsField(
              controller: medicationsTextController,
              focusNode: medicationsFocusNode,
              validator: medicationsTextControllerValidator,
            ),
            _ConditionsField(
              controller: conditionsTextController,
              focusNode: conditionsFocusNode,
              validator: conditionsTextControllerValidator,
            ),
            _BloodTypeField(
              value: bloodTypeValue,
              controller: bloodTypeValueController,
              onChanged: onBloodTypeChanged,
            ),
          ].divide(const SizedBox(height: 24.0)),
        ),
      ),
    );
  }
}

class _AllergiesField extends StatelessWidget {
  const _AllergiesField({
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
          'Do you have any allergies?',
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
            maxLines: 3,
            decoration: InputDecoration(
              isDense: false,
              labelStyle:
                  FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.0,
                        lineHeight: 1.5,
                      ),
              hintText: 'List any allergies (e.g., penicillin, nuts)',
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

class _MedicationsField extends StatelessWidget {
  const _MedicationsField({
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
          'Current Medications',
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
            maxLines: 3,
            decoration: InputDecoration(
              isDense: false,
              labelStyle:
                  FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.0,
                        lineHeight: 1.5,
                      ),
              hintText: 'List current medications',
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

class _ConditionsField extends StatelessWidget {
  const _ConditionsField({
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
          'Chronic Conditions',
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
            maxLines: 3,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              isDense: false,
              labelStyle:
                  FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.0,
                        lineHeight: 1.5,
                      ),
              hintText: 'Ongoing health conditions',
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

class _BloodTypeField extends StatelessWidget {
  const _BloodTypeField({
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
          'Blood Type (if known)',
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
                lineHeight: 1.5,
              ),
        ),
        FlutterFlowDropDown<String>(
          controller: controller ?? FormFieldController<String>(value),
          options: const [
            'A+',
            'A-',
            'B+',
            'B-',
            'AB+',
            'AB-',
            'O+',
            'O-',
            'Unknown'
          ],
          onChanged: onChanged,
          width: double.infinity,
          height: 48.0,
          textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
              ),
          hintText: 'Unknown',
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

class _LocationInformationSection extends StatelessWidget {
  const _LocationInformationSection({
    required this.stateValue,
    required this.stateValueController,
    required this.onStateChanged,
    required this.lgaValue,
    required this.lgaValueController,
    required this.onLgaChanged,
  });

  final String? stateValue;
  final FormFieldController<String>? stateValueController;
  final ValueChanged<String?> onStateChanged;
  final String? lgaValue;
  final FormFieldController<String>? lgaValueController;
  final ValueChanged<String?> onLgaChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).micContainerBackground,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).accent4,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LOCATION INFORMATION',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Clash Grotesk',
                    letterSpacing: 0.0,
                    lineHeight: 1.5,
                  ),
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
        ),
      ),
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
          controller: controller ?? FormFieldController<String>(value),
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
          controller: controller ?? FormFieldController<String>(value),
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

class _SaveButtonSection extends StatelessWidget {
  const _SaveButtonSection({required this.onSave});

  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FFButtonWidget(
              onPressed: onSave,
              text: 'SAVE CHANGES',
              options: FFButtonOptions(
                width: double.infinity,
                height: 43.0,
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                iconPadding: EdgeInsetsDirectional.zero,
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'Clash Grotesk',
                      color: FlutterFlowTheme.of(context).info,
                      letterSpacing: 0.0,
                      lineHeight: 1.2,
                    ),
                elevation: 0.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

