import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSelectionWidget extends StatefulWidget {
  const LanguageSelectionWidget({super.key});

  static const String routeName = 'LanguageSelection';
  static const String routePath = '/languageSelection';

  @override
  State<LanguageSelectionWidget> createState() =>
      _LanguageSelectionWidgetState();
}

class _LanguageSelectionWidgetState extends State<LanguageSelectionWidget> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 56.0, 16.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const _HeaderSection(),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: GridView(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 0.68,
                          ),
                          scrollDirection: Axis.vertical,
                          children: const [
                            _LanguageCard(
                              language: 'en',
                              languageName: 'English',
                              doctorName: 'Dr Lucy',
                              imagePath: 'assets/images/En_Image_Container.png',
                              bubbleImagePath:
                                  'assets/images/English_Chat_Bubble.png',
                              bubbleAlignment: AlignmentDirectional(1.2, -0.9),
                              bubbleWidth: 94.0,
                              bubbleHeight: 44.0,
                            ),
                            _LanguageCard(
                              language: 'yo',
                              languageName: 'Yoruba',
                              doctorName: 'Dr Sade',
                              imagePath: 'assets/images/Yo_Image_Container.png',
                              bubbleImagePath:
                                  'assets/images/Yorb_Chat_Bubble.png',
                              bubbleAlignment: AlignmentDirectional(1.2, -0.9),
                              bubbleWidth: 120.0,
                              bubbleHeight: 44.0,
                            ),
                            _LanguageCard(
                              language: 'ha',
                              languageName: 'Hausa',
                              doctorName: 'Dr Amina',
                              imagePath: 'assets/images/Ha_Image_Container.png',
                              bubbleImagePath:
                                  'assets/images/Hausa_Chat_Bubble.png',
                              bubbleAlignment: AlignmentDirectional(0.4, -0.9),
                              bubbleWidth: 78.0,
                              bubbleHeight: 44.0,
                            ),
                            _LanguageCard(
                              language: 'ig',
                              languageName: 'Igbo',
                              doctorName: 'Dr Ngozi',
                              imagePath: 'assets/images/Ig_Image_Container.png',
                              bubbleImagePath:
                                  'assets/images/Igbo_Chat_Bubble.png',
                              bubbleAlignment: AlignmentDirectional(1.2, -0.9),
                              bubbleWidth: 120.0,
                              bubbleHeight: 44.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ].divide(const SizedBox(height: 24.0)),
            ),
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
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'CHOOSE YOUR LANGUAGE',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).headlineSmall.override(
                  fontFamily: 'Clash Grotesk',
                  letterSpacing: 0.0,
                ),
          ),
          Text(
            'Select your preferred language for medical assistance',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'Gilroy',
                  letterSpacing: 0.0,
                  lineHeight: 1.5,
                ),
          ),
        ].divide(const SizedBox(height: 4.0)),
      ),
    );
  }
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({
    required this.language,
    required this.languageName,
    required this.doctorName,
    required this.imagePath,
    required this.bubbleImagePath,
    required this.bubbleAlignment,
    required this.bubbleWidth,
    required this.bubbleHeight,
  });

  final String language;
  final String languageName;
  final String doctorName;
  final String imagePath;
  final String bubbleImagePath;
  final AlignmentDirectional bubbleAlignment;
  final double bubbleWidth;
  final double bubbleHeight;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        FFAppState().selectedLanguage = language;
        FFAppState().selectedLanguageName = languageName;
        FFAppState().selectedDoctorName = doctorName;

        context.pushNamed(
          ChatScreenWidget.routeName,
          extra: <String, dynamic>{
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.rightToLeft,
            ),
          },
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 19.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      imagePath,
                      width: double.infinity,
                      height: 164.0,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        languageName.toUpperCase(),
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              fontFamily: 'Clash Grotesk',
                              letterSpacing: 0.0,
                              lineHeight: 1.2,
                            ),
                      ),
                      Text(
                        doctorName,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Gilroy',
                              letterSpacing: 0.0,
                              lineHeight: 1.5,
                            ),
                      ),
                    ].divide(const SizedBox(height: 4.0)),
                  ),
                ].divide(const SizedBox(height: 8.0)),
              ),
            ),
            Align(
              alignment: bubbleAlignment,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  bubbleImagePath,
                  width: bubbleWidth,
                  height: bubbleHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

