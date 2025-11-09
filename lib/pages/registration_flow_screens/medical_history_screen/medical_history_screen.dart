import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicalHistoryScreenWidget extends StatefulWidget {
  const MedicalHistoryScreenWidget({super.key});

  static const String routeName = 'MedicalHistoryScreen';
  static const String routePath = '/medicalHistoryScreen';

  @override
  State<MedicalHistoryScreenWidget> createState() =>
      _MedicalHistoryScreenWidgetState();
}

class _MedicalHistoryScreenWidgetState
    extends State<MedicalHistoryScreenWidget> {
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
  bool? saveMedicalData;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _allergiesTextController = TextEditingController();
    _allergiesFocusNode = FocusNode();
    _medicationsTextController = TextEditingController();
    _medicationsFocusNode = FocusNode();
    _conditionsTextController = TextEditingController();
    _conditionsFocusNode = FocusNode();
  }

  @override
  void dispose() {
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
                              'MEDICAL INFORMATION',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Clash Grotesk',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            _MedicalFormSection(
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
                          saveMedicalData = await actions.saveMedicalData(
                            _allergiesTextController.text,
                            _medicationsTextController.text,
                            _conditionsTextController.text,
                            _bloodTypeValue ?? 'Unknown',
                          );
                          if (saveMedicalData == true) {
                            context.pushNamed(
                              EmergencyContactsScreenWidget.routeName,
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
                                  'Failed to save medical data',
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

class _MedicalFormSection extends StatelessWidget {
  const _MedicalFormSection({
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
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          controller: controller ?? FormFieldController<String>(null),
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
                color: FlutterFlowTheme.of(context).primaryBackground,
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
              text: 'CONTINUE',
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

