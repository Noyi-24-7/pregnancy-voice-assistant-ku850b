import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneVerifyScreenWidget extends StatefulWidget {
  const PhoneVerifyScreenWidget({super.key});

  static const String routeName = 'PhoneVerifyScreen';
  static const String routePath = '/phoneVerifyScreen';

  @override
  State<PhoneVerifyScreenWidget> createState() =>
      _PhoneVerifyScreenWidgetState();
}

class _PhoneVerifyScreenWidgetState extends State<PhoneVerifyScreenWidget> {
  late TextEditingController _pinCodeController;
  late FocusNode _pinCodeFocusNode;
  String? Function(BuildContext, String?)? _pinCodeControllerValidator;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _pinCodeController = TextEditingController();
    _pinCodeFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _pinCodeFocusNode.dispose();
    _pinCodeController.dispose();
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const _HeaderSection(),
              _ContentSection(
                pinCodeController: _pinCodeController,
                pinCodeFocusNode: _pinCodeFocusNode,
                pinCodeControllerValidator: _pinCodeControllerValidator,
              ),
            ]
                .divide(const SizedBox(height: 80.0))
                .addToEnd(const SizedBox(height: 184.0)),
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
  const _ContentSection({
    required this.pinCodeController,
    required this.pinCodeFocusNode,
    this.pinCodeControllerValidator,
  });

  final TextEditingController pinCodeController;
  final FocusNode pinCodeFocusNode;
  final String? Function(BuildContext, String?)? pinCodeControllerValidator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ENTER VERIFICATION CODE',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Clash Grotesk',
                      letterSpacing: 0.0,
                      lineHeight: 1.2,
                    ),
              ),
              Text(
                'We sent a 6-digit code to ${valueOrDefault<String>(
                  currentPhoneNumber,
                  '+234 801 234 5678',
                )}',
                textAlign: TextAlign.start,
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'Gilroy',
                      letterSpacing: 0.0,
                      lineHeight: 1.5,
                    ),
              ),
            ].divide(const SizedBox(height: 4.0)),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PinCodeTextField(
                    autoDisposeControllers: false,
                    appContext: context,
                    length: 6,
                    textStyle:
                        FlutterFlowTheme.of(context).bodyLarge.override(
                              fontFamily: 'Gilroy',
                              letterSpacing: 0.0,
                            ),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    enableActiveFill: true,
                    autoFocus: true,
                    focusNode: pinCodeFocusNode,
                    enablePinAutofill: false,
                    errorTextSpace: 16.0,
                    showCursor: true,
                    cursorColor: FlutterFlowTheme.of(context).primary,
                    obscureText: false,
                    hintCharacter: '-',
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      fieldHeight: 48.0,
                      fieldWidth: 50.5,
                      borderWidth: 0.0,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8.0),
                        bottomRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0),
                        topRight: Radius.circular(8.0),
                      ),
                      shape: PinCodeFieldShape.box,
                      activeColor: FlutterFlowTheme.of(context).primaryText,
                      inactiveColor: FlutterFlowTheme.of(context).alternate,
                      selectedColor: FlutterFlowTheme.of(context).primary,
                      activeFillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      inactiveFillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      selectedFillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    controller: pinCodeController,
                    onChanged: (_) {},
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: pinCodeControllerValidator?.asValidator(context),
                  ),
                ].divide(const SizedBox(height: 8.0)),
              ),
              _ButtonSection(pinCodeController: pinCodeController),
            ].divide(const SizedBox(height: 24.0)),
          ),
        ].divide(const SizedBox(height: 40.0)),
      ),
    );
  }
}

class _ButtonSection extends StatelessWidget {
  const _ButtonSection({required this.pinCodeController});

  final TextEditingController pinCodeController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        FFButtonWidget(
          onPressed: () async {
            context.safePop();
          },
          text: 'BACK',
          options: FFButtonOptions(
            width: double.infinity,
            height: 43.0,
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            iconPadding: EdgeInsetsDirectional.zero,
            color: FlutterFlowTheme.of(context).accent4,
            textStyle: FlutterFlowTheme.of(context).titleLarge.override(
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
          onPressed: () async {
            GoRouter.of(context).prepareAuthEvent();
            final smsCodeVal = pinCodeController.text;
            if (smsCodeVal.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Enter SMS verification code.'),
                ),
              );
              return;
            }
            final phoneVerifiedUser = await authManager.verifySmsCode(
              context: context,
              smsCode: smsCodeVal,
            );
            if (phoneVerifiedUser == null) {
              return;
            }

            await Future.delayed(
              const Duration(
                milliseconds: 1200,
              ),
            );

            context.pushNamedAuth(
                RegistrationScreenWidget.routeName, context.mounted);
          },
          text: 'VERIFY & CONTINUE',
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
      ].divide(const SizedBox(height: 8.0)),
    );
  }
}

