import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhoneAuthScreenWidget extends StatefulWidget {
  const PhoneAuthScreenWidget({super.key});

  static const String routeName = 'PhoneAuthScreen';
  static const String routePath = '/phoneAuthScreen';

  @override
  State<PhoneAuthScreenWidget> createState() => _PhoneAuthScreenWidgetState();
}

class _PhoneAuthScreenWidgetState extends State<PhoneAuthScreenWidget> {
  late TextEditingController _textController;
  late FocusNode _textFieldFocusNode;
  String? Function(BuildContext, String?)? _textControllerValidator;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _textFieldFocusNode = FocusNode();
    authManager.handlePhoneAuthStateChanges(context);
  }

  @override
  void dispose() {
    _textFieldFocusNode.dispose();
    _textController.dispose();
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
                textController: _textController,
                textFieldFocusNode: _textFieldFocusNode,
                textControllerValidator: _textControllerValidator,
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
    required this.textController,
    required this.textFieldFocusNode,
    this.textControllerValidator,
  });

  final TextEditingController? textController;
  final FocusNode? textFieldFocusNode;
  final String? Function(BuildContext, String?)? textControllerValidator;

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
                'VERIFY YOUR PHONE NUMBER',
                style: FlutterFlowTheme.of(context).headlineSmall.override(
                      fontFamily: 'Clash Grotesk',
                      letterSpacing: 0.0,
                      lineHeight: 1.2,
                    ),
              ),
              Text(
                'We\'ll send you a verification code to confirm your number',
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
                  Text(
                    'Enter your phone number',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Gilroy',
                          letterSpacing: 0.0,
                          lineHeight: 1.5,
                        ),
                  ),
                  Container(
                    width: double.infinity,
                    child: TextFormField(
                      controller: textController,
                      focusNode: textFieldFocusNode,
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
                        hintText: '+234 801 234 5678',
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
                      validator: textControllerValidator?.asValidator(context),
                    ),
                  ),
                ].divide(const SizedBox(height: 8.0)),
              ),
              _ButtonSection(textController: textController),
            ].divide(const SizedBox(height: 24.0)),
          ),
        ].divide(const SizedBox(height: 40.0)),
      ),
    );
  }
}

class _ButtonSection extends StatelessWidget {
  const _ButtonSection({required this.textController});

  final TextEditingController? textController;

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
            final phoneNumberVal = textController?.text ?? '';
            if (phoneNumberVal.isEmpty || !phoneNumberVal.startsWith('+')) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'Phone Number is required and has to start with +.'),
                ),
              );
              return;
            }
            await authManager.beginPhoneAuth(
              context: context,
              phoneNumber: phoneNumberVal,
              onCodeSent: (context) async {
                context.goNamedAuth(
                  PhoneVerifyScreenWidget.routeName,
                  context.mounted,
                  ignoreRedirect: true,
                );
              },
            );
          },
          text: 'SEND VERIFICATION CODE',
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

