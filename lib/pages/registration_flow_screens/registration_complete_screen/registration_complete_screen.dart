import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class RegistrationCompleteScreenWidget extends StatefulWidget {
  const RegistrationCompleteScreenWidget({super.key});

  static const String routeName = 'RegistrationCompleteScreen';
  static const String routePath = '/registrationCompleteScreen';

  @override
  State<RegistrationCompleteScreenWidget> createState() =>
      _RegistrationCompleteScreenWidgetState();
}

class _RegistrationCompleteScreenWidgetState
    extends State<RegistrationCompleteScreenWidget> {
  dynamic assignedDoctorInfo;
  bool assignmentComplete = false;
  String? assignDoctorToPatient;
  dynamic? getDoctorInfo;
  String? assignDoctorToPatientBtn;
  dynamic? getDoctorInfoBtn;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      assignDoctorToPatient = await actions.assignDoctorToPatient();
      if (assignDoctorToPatient != null && assignDoctorToPatient != '') {
        getDoctorInfo = await actions.getDoctorInfo(assignDoctorToPatient!);
        assignedDoctorInfo = getDoctorInfo;
        if (mounted) {
          setState(() {});
        }
        assignmentComplete = true;
        if (mounted) {
          setState(() {});
        }
        await Future.delayed(const Duration(milliseconds: 3000));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Unable to assign doctor. Please try again.',
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                    fontFamily: 'Gilroy',
                    color: FlutterFlowTheme.of(context).primaryText,
                    letterSpacing: 0.0,
                  ),
            ),
            duration: const Duration(milliseconds: 4000),
            backgroundColor:
                FlutterFlowTheme.of(context).micContainerBackground,
          ),
        );
      }
    });
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
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: _LoadingSection(
                        assignmentComplete: assignmentComplete,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: _SuccessSection(
                  assignmentComplete: assignmentComplete,
                  getDoctorInfo: getDoctorInfo,
                  assignedDoctorInfo: assignedDoctorInfo,
                ),
              ),
              if (!assignmentComplete)
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: _RetryButton(
                    onRetry: () async {
                      assignDoctorToPatientBtn =
                          await actions.assignDoctorToPatient();
                      if (assignDoctorToPatientBtn != null &&
                          assignDoctorToPatientBtn != '') {
                        getDoctorInfoBtn = await actions.getDoctorInfo(
                          assignDoctorToPatient!,
                        );
                        assignedDoctorInfo = getDoctorInfoBtn;
                        if (mounted) {
                          setState(() {});
                        }
                        assignmentComplete = true;
                        if (mounted) {
                          setState(() {});
                        }
                        await Future.delayed(const Duration(milliseconds: 3000));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Unable to assign doctor. Please try again.',
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
            ].divide(const SizedBox(height: 40.0)),
          ),
        ),
      ),
    );
  }
}

class _LoadingSection extends StatelessWidget {
  const _LoadingSection({required this.assignmentComplete});

  final bool assignmentComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                color: const Color(0xFFC0BEC8),
                borderRadius: BorderRadius.circular(1000.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/Covid_pregnant_woman.gif',
                  width: 80.0,
                  height: 80.0,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'REGISTRATION COMPLETE',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'Clash Grotesk',
                        fontSize: 20.0,
                        letterSpacing: 0.0,
                      ),
                ),
                Text(
                  'We're assigning you a doctor...',
                  textAlign: TextAlign.center,
                  style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.0,
                        lineHeight: 1.5,
                      ),
                ),
              ].divide(const SizedBox(height: 4.0)),
            ),
          ].divide(const SizedBox(height: 16.0)),
        ),
        if (!assignmentComplete)
          CircularPercentIndicator(
            percent: 1.0,
            radius: 20.0,
            lineWidth: 4.0,
            animation: true,
            animateFromLastPercent: true,
            progressColor: FlutterFlowTheme.of(context).primary,
            backgroundColor: FlutterFlowTheme.of(context).accent4,
          ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Text(
                'This may take a few moments while we find the best doctor for your location and language preferences.',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'Gilroy',
                      letterSpacing: 0.0,
                      lineHeight: 1.5,
                    ),
              ),
            ),
          ],
        ),
      ].divide(const SizedBox(height: 64.0)),
    );
  }
}

class _SuccessSection extends StatelessWidget {
  const _SuccessSection({
    required this.assignmentComplete,
    required this.getDoctorInfo,
    required this.assignedDoctorInfo,
  });

  final bool assignmentComplete;
  final dynamic? getDoctorInfo;
  final dynamic? assignedDoctorInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (assignmentComplete)
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
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
                      getDoctorInfo,
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
                      assignedDoctorInfo,
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
        if (assignmentComplete)
          FFButtonWidget(
            onPressed: () async {
              context.pushNamed(HomeScreenWidget.routeName);
            },
            text: 'START USING PREGGOS',
            options: FFButtonOptions(
              width: double.infinity,
              height: 43.0,
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
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
      ].divide(const SizedBox(height: 24.0)),
    );
  }
}

class _RetryButton extends StatelessWidget {
  const _RetryButton({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return FFButtonWidget(
      onPressed: onRetry,
      text: 'RETRY',
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
    );
  }
}

