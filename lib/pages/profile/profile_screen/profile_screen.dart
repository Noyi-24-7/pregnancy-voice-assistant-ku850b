import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class ProfileScreenWidget extends StatefulWidget {
  const ProfileScreenWidget({super.key});

  static const String routeName = 'ProfileScreen';
  static const String routePath = '/profileScreen';

  @override
  State<ProfileScreenWidget> createState() => _ProfileScreenWidgetState();
}

class _ProfileScreenWidgetState extends State<ProfileScreenWidget> {
  dynamic doctorInfo;
  dynamic? getDoctorInfo;
  bool? performLogout;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      getDoctorInfo = await actions.getDoctorInfo(
        getJsonField(
          FFAppState().currentPatientData,
          r'''$.assignedDoctor''',
        ).toString(),
      );
      doctorInfo = getDoctorInfo;
      if (mounted) {
        setState(() {});
      }
    });
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.infinity,
              height: 852.0,
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: double.infinity, height: 139.0),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const _PersonalInformationSection(),
                              const _MedicalInformationSection(),
                              const _EmergencyContactsSection(),
                              _AssignedDoctorSection(doctorInfo: doctorInfo),
                              _LogoutButton(
                                onLogout: () async {
                                  var confirmDialogResponse =
                                      await showDialog<bool>(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: const Text('Sign Out'),
                                                content: const Text(
                                                    'Are you sure you want to sign out of your account?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            false),
                                                    child: const Text('CANCEL'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            true),
                                                    child: const Text('LOGOUT'),
                                                  ),
                                                ],
                                              );
                                            },
                                          ) ??
                                          false;
                                  performLogout = await actions.performLogout();
                                  if (performLogout == true) {
                                    context.pushNamed(
                                      WelcomeScreenWidget.routeName,
                                      extra: <String, dynamic>{
                                        kTransitionInfoKey: TransitionInfo(
                                          hasTransition: true,
                                          transitionType:
                                              PageTransitionType.rightToLeft,
                                        ),
                                      },
                                    );

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Successfully signed out',
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
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Failed to sign out. Please try again.',
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
                            ]
                                .divide(const SizedBox(height: 16.0))
                                .addToEnd(const SizedBox(height: 80.0)),
                          ),
                        ),
                      ].divide(const SizedBox(height: 24.0)),
                    ),
                  ),
                  const _ProfileHeaderSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileHeaderSection extends StatelessWidget {
  const _ProfileHeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.zero,
        border: Border.all(
          color: FlutterFlowTheme.of(context).accent4,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 56.0, 16.0, 24.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(
                      getJsonField(
                        FFAppState().currentPatientData,
                        r'''$.profile.name''',
                      )?.toString(),
                      'Adebayo Johnson',
                    ),
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Clash Grotesk',
                          fontSize: 20.0,
                          letterSpacing: 0.0,
                          lineHeight: 1.5,
                        ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      FFAppState().currentUserPhone,
                      '+234 801 234 5678',
                    ),
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Gilroy',
                          letterSpacing: 0.0,
                          lineHeight: 1.5,
                        ),
                  ),
                ].divide(const SizedBox(height: 8.0)),
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                context.pushNamed(EditProfileScreenWidget.routeName);
              },
              text: 'EDIT PROFILE',
              options: FFButtonOptions(
                height: 30.0,
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                iconPadding: EdgeInsetsDirectional.zero,
                color: FlutterFlowTheme.of(context).primaryBackground,
                textStyle: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'Clash Grotesk',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 12.0,
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

class _PersonalInformationSection extends StatelessWidget {
  const _PersonalInformationSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
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
            _InfoRow(
              label: 'Age',
              value: valueOrDefault<String>(
                getJsonField(
                  FFAppState().currentPatientData,
                  r'''$.profile.age''',
                )?.toString(),
                '28',
              ),
            ),
            _InfoRow(
              label: 'Gender',
              value: valueOrDefault<String>(
                getJsonField(
                  FFAppState().currentPatientData,
                  r'''$.profile.gender''',
                )?.toString(),
                'Female',
              ),
            ),
            _InfoRow(
              label: 'Location',
              value: valueOrDefault<String>(
                '${getJsonField(
                  FFAppState().currentPatientData,
                  r'''$.profile.location.lga''',
                ).toString()}, ${getJsonField(
                  FFAppState().currentPatientData,
                  r'''$.profile.location.state''',
                ).toString()}',
                'Ikeja, Lagos',
              ),
            ),
            _InfoRow(
              label: 'Language',
              value: valueOrDefault<String>(
                getJsonField(
                  FFAppState().currentPatientData,
                  r'''$.profile.language''',
                )?.toString(),
                'English',
              ),
            ),
            _InfoRow(
              label: 'Member Since',
              value: valueOrDefault<String>(
                getJsonField(
                  FFAppState().currentPatientData,
                  r'''$.profile.registrationDate''',
                )?.toString(),
                'August 20, 2025',
              ),
            ),
          ].divide(const SizedBox(height: 24.0)),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: FlutterFlowTheme.of(context).labelLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
              ),
        ),
        Text(
          value,
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
              ),
        ),
      ],
    );
  }
}

class _MedicalInformationSection extends StatelessWidget {
  const _MedicalInformationSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
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
            _MedicalInfoItem(
              label: 'Allergies',
              value: valueOrDefault<String>(
                getJsonField(
                  FFAppState().currentPatientData,
                  r'''$.medical.allergies''',
                )?.toString(),
                'Penicillin, Shellfish',
              ),
            ),
            _MedicalInfoItem(
              label: 'Current Medications',
              value: valueOrDefault<String>(
                getJsonField(
                  FFAppState().currentPatientData,
                  r'''$.medical.currentMedications''',
                )?.toString(),
                'Lisinopril 10mg daily, Vitamin D',
              ),
            ),
            _MedicalInfoItem(
              label: 'Chronic Conditions',
              value: valueOrDefault<String>(
                getJsonField(
                  FFAppState().currentPatientData,
                  r'''$.medical.chronicConditions''',
                )?.toString(),
                'Hypertension (controlled)',
              ),
            ),
            _MedicalInfoItem(
              label: 'Blood Type',
              value: valueOrDefault<String>(
                getJsonField(
                  FFAppState().currentPatientData,
                  r'''$.medical.bloodType''',
                )?.toString(),
                'O+',
              ),
            ),
          ].divide(const SizedBox(height: 24.0)),
        ),
      ),
    );
  }
}

class _MedicalInfoItem extends StatelessWidget {
  const _MedicalInfoItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: FlutterFlowTheme.of(context).labelLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
                lineHeight: 1.5,
              ),
        ),
        Text(
          value,
          style: FlutterFlowTheme.of(context).bodyLarge.override(
                fontFamily: 'Gilroy',
                letterSpacing: 0.0,
                lineHeight: 1.5,
              ),
        ),
      ].divide(const SizedBox(height: 4.0)),
    );
  }
}

class _EmergencyContactsSection extends StatelessWidget {
  const _EmergencyContactsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
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
              'EMERGENCY CONTACTS',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Clash Grotesk',
                    letterSpacing: 0.0,
                    lineHeight: 1.5,
                  ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).micContainerBackground,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: FlutterFlowTheme.of(context).primary,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).primary,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            4.0, 2.0, 4.0, 2.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'PRIMARY',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Clash Grotesk',
                                    color: FlutterFlowTheme.of(context).info,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    lineHeight: 1.5,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        getJsonField(
                          FFAppState().currentPatientData,
                          r'''$.medical.emergencyContacts[0].name''',
                        )?.toString(),
                        'Funmi Johnson',
                      ),
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Gilroy',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            lineHeight: 1.5,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        getJsonField(
                          FFAppState().currentPatientData,
                          r'''$.medical.emergencyContacts[0].relationship''',
                        )?.toString(),
                        'Spouse',
                      ),
                      style: FlutterFlowTheme.of(context).labelMedium.override(
                            fontFamily: 'Gilroy',
                            letterSpacing: 0.0,
                            lineHeight: 1.5,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        getJsonField(
                          FFAppState().currentPatientData,
                          r'''$.medical.emergencyContacts[0].phone''',
                        )?.toString(),
                        '+234 703 456 7890',
                      ),
                      style: FlutterFlowTheme.of(context).titleSmall.override(
                            fontFamily: 'Gilroy',
                            color: FlutterFlowTheme.of(context).primary,
                            letterSpacing: 0.0,
                            lineHeight: 1.5,
                          ),
                    ),
                  ].divide(const SizedBox(height: 4.0)),
                ),
              ),
            ),
          ].divide(const SizedBox(height: 24.0)),
        ),
      ),
    );
  }
}

class _AssignedDoctorSection extends StatelessWidget {
  const _AssignedDoctorSection({required this.doctorInfo});

  final dynamic doctorInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
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
              'ASSIGNED DOCTOR',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Clash Grotesk',
                    letterSpacing: 0.0,
                    lineHeight: 1.5,
                  ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).micContainerBackground,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getJsonField(
                              doctorInfo,
                              r'''$.profile.name''',
                            ).toString(),
                            style: FlutterFlowTheme.of(context).titleLarge.override(
                                  fontFamily: 'Clash Grotesk',
                                  letterSpacing: 0.0,
                                  lineHeight: 1.5,
                                ),
                          ),
                          Text(
                            getJsonField(
                              doctorInfo,
                              r'''$.profile.specialization''',
                            ).toString(),
                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Gilroy',
                                  letterSpacing: 0.0,
                                  lineHeight: 1.5,
                                ),
                          ),
                        ].divide(const SizedBox(height: 8.0)),
                      ),
                    ),
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed(DoctorPatientChatWidget.routeName);
                    },
                    text: 'CONTACT DOCTOR',
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
                  Text(
                    'Assigned on: ${getJsonField(
                      FFAppState().currentPatientData,
                      r'''$.assignmentDate''',
                    ).toString()}',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Gilroy',
                          letterSpacing: 0.0,
                          lineHeight: 1.5,
                        ),
                  ),
                ].divide(const SizedBox(height: 16.0)),
              ),
            ),
          ].divide(const SizedBox(height: 24.0)),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.onLogout});

  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: onLogout,
      text: 'LOGOUT',
      options: FFButtonOptions(
        width: double.infinity,
        height: 43.0,
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
        iconPadding: EdgeInsetsDirectional.zero,
        color: FlutterFlowTheme.of(context).primaryBackground,
        textStyle: FlutterFlowTheme.of(context).titleLarge.override(
              fontFamily: 'Clash Grotesk',
              color: FlutterFlowTheme.of(context).tertiary,
              letterSpacing: 0.0,
              lineHeight: 1.2,
            ),
        elevation: 0.0,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }
}

