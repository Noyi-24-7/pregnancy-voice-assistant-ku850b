import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmergencyContactsScreenWidget extends StatefulWidget {
  const EmergencyContactsScreenWidget({super.key});

  static const String routeName = 'EmergencyContactsScreen';
  static const String routePath = '/emergencyContactsScreen';

  @override
  State<EmergencyContactsScreenWidget> createState() =>
      _EmergencyContactsScreenWidgetState();
}

class _EmergencyContactsScreenWidgetState
    extends State<EmergencyContactsScreenWidget> {
  bool showSecondaryContact = false;
  late TextEditingController _primaryNameTextController;
  late FocusNode _primaryNameFocusNode;
  String? Function(BuildContext, String?)? _primaryNameTextControllerValidator;
  String? _primaryRelationshipValue;
  FormFieldController<String>? _primaryRelationshipValueController;
  late TextEditingController _primaryPhoneTextController;
  late FocusNode _primaryPhoneFocusNode;
  String? Function(BuildContext, String?)? _primaryPhoneTextControllerValidator;
  bool? saveEmergencyContacts;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _primaryNameTextController = TextEditingController();
    _primaryNameFocusNode = FocusNode();
    _primaryPhoneTextController = TextEditingController();
    _primaryPhoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _primaryNameFocusNode.dispose();
    _primaryNameTextController.dispose();
    _primaryPhoneFocusNode.dispose();
    _primaryPhoneTextController.dispose();
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
                              'EMERGENCY CONTACT',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Clash Grotesk',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                            _ContactFormSection(
                              primaryNameTextController:
                                  _primaryNameTextController,
                              primaryNameFocusNode: _primaryNameFocusNode,
                              primaryNameTextControllerValidator:
                                  _primaryNameTextControllerValidator,
                              primaryRelationshipValue: _primaryRelationshipValue,
                              primaryRelationshipValueController:
                                  _primaryRelationshipValueController,
                              onRelationshipChanged: (val) {
                                setState(() {
                                  _primaryRelationshipValue = val;
                                });
                              },
                              primaryPhoneTextController:
                                  _primaryPhoneTextController,
                              primaryPhoneFocusNode: _primaryPhoneFocusNode,
                              primaryPhoneTextControllerValidator:
                                  _primaryPhoneTextControllerValidator,
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
                          saveEmergencyContacts =
                              await actions.saveEmergencyContacts(
                            _primaryNameTextController.text,
                            _primaryRelationshipValue ?? '',
                            _primaryPhoneTextController.text,
                            '',
                            '',
                            '',
                          );
                          if (saveEmergencyContacts == true) {
                            await actions.assignDoctorToPatient();

                            context.pushNamed(
                              RegistrationCompleteScreenWidget.routeName,
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
                                  'Failed to complete registration. Please try again.',
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

class _ContactFormSection extends StatelessWidget {
  const _ContactFormSection({
    required this.primaryNameTextController,
    required this.primaryNameFocusNode,
    this.primaryNameTextControllerValidator,
    required this.primaryRelationshipValue,
    required this.primaryRelationshipValueController,
    required this.onRelationshipChanged,
    required this.primaryPhoneTextController,
    required this.primaryPhoneFocusNode,
    this.primaryPhoneTextControllerValidator,
  });

  final TextEditingController primaryNameTextController;
  final FocusNode primaryNameFocusNode;
  final String? Function(BuildContext, String?)?
      primaryNameTextControllerValidator;
  final String? primaryRelationshipValue;
  final FormFieldController<String>? primaryRelationshipValueController;
  final ValueChanged<String?> onRelationshipChanged;
  final TextEditingController primaryPhoneTextController;
  final FocusNode primaryPhoneFocusNode;
  final String? Function(BuildContext, String?)?
      primaryPhoneTextControllerValidator;

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
            _NameField(
              controller: primaryNameTextController,
              focusNode: primaryNameFocusNode,
              validator: primaryNameTextControllerValidator,
            ),
            _RelationshipField(
              value: primaryRelationshipValue,
              controller: primaryRelationshipValueController,
              onChanged: onRelationshipChanged,
            ),
            _PhoneField(
              controller: primaryPhoneTextController,
              focusNode: primaryPhoneFocusNode,
              validator: primaryPhoneTextControllerValidator,
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
              hintText: 'Enter contact\'s full name',
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

class _RelationshipField extends StatelessWidget {
  const _RelationshipField({
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
          'Relationship',
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
                lineHeight: 1.5,
              ),
        ),
        FlutterFlowDropDown<String>(
          controller: controller ??
              FormFieldController<String>(null),
          options: const [
            'Spouse',
            'Parent',
            'Child',
            'Sibling',
            'Friend',
            'Other'
          ],
          onChanged: onChanged,
          width: double.infinity,
          height: 48.0,
          textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
              ),
          hintText: 'Select relationship',
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: FlutterFlowTheme.of(context).secondaryText,
            size: 24.0,
          ),
          fillColor:
              FlutterFlowTheme.of(context).secondaryBackground,
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

class _PhoneField extends StatelessWidget {
  const _PhoneField({
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
          'Phone Number',
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
              hintText: 'Enter number',
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

