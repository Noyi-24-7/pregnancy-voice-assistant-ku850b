import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';

class WelcomeScreenWidget extends StatelessWidget {
  const WelcomeScreenWidget({super.key});

  static const String routeName = 'WelcomeScreen';
  static const String routePath = '/welcomeScreen';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const _HeaderSection(),
            const _ContentSection(),
          ].divide(const SizedBox(height: 80.0)),
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
      height: 320.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primary,
        borderRadius: BorderRadius.zero,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'assets/images/Pregnant_Woman_&_Baby_LOGO.png',
              width: 80.0,
              height: 120.0,
              fit: BoxFit.contain,
            ),
          ),
        ].addToEnd(const SizedBox(height: 80.0)),
      ),
    );
  }
}

class _ContentSection extends StatelessWidget {
  const _ContentSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'WELCOME TO PREGGOS',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Clash Grotesk',
                      letterSpacing: 0.0,
                      lineHeight: 1.2,
                    ),
              ),
              Text(
                'Your AI-powered health companion with real doctor support',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'Gilroy',
                      letterSpacing: 0.0,
                      lineHeight: 1.5,
                    ),
              ),
            ].divide(const SizedBox(height: 4.0)),
          ),
          FFButtonWidget(
            onPressed: () async {
              context.pushNamed(PhoneAuthScreenWidget.routeName);
            },
            text: 'GET STARTED',
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
        ].divide(const SizedBox(height: 40.0)),
      ),
    );
  }
}

