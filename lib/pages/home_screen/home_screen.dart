import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class HomeScreenWidget extends StatefulWidget {
  const HomeScreenWidget({super.key});

  static const String routeName = 'HomeScreen';
  static const String routePath = '/homeScreen';

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  bool? _loadPatientProfile;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _loadPatientProfile = await actions.loadPatientProfile();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _loadPatientProfile == true ? 'Success' : 'Failed',
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const _HeaderSection(),
            const _ContentSection(),
          ].divide(const SizedBox(height: 40.0)),
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
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(1000.0),
          bottomRight: Radius.circular(1000.0),
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(0.0),
        ),
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
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'ASK ME ANYTHING...',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
                fontFamily: 'Clash Grotesk',
                letterSpacing: 0.0,
              ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _MedicalAssistantCard(),
              _LanguageTranslationCard(),
            ].divide(const SizedBox(height: 16.0)),
          ),
        ),
      ].divide(const SizedBox(height: 32.0)),
    );
  }
}

class _MedicalAssistantCard extends StatelessWidget {
  const _MedicalAssistantCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        context.pushNamed(
          LanguageSelectionWidget.routeName,
          extra: <String, dynamic>{
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.rightToLeft,
            ),
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).accent2,
                  borderRadius: BorderRadius.circular(1000.0),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Medical Assistant',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Gilroy',
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                        ),
                  ),
                  Text(
                    'Get health advice in your language',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Gilroy',
                          letterSpacing: 0.0,
                        ),
                  ),
                ].divide(const SizedBox(height: 4.0)),
              ),
            ].divide(const SizedBox(width: 12.0)),
          ),
        ),
      ),
    );
  }
}

class _LanguageTranslationCard extends StatelessWidget {
  const _LanguageTranslationCard();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        context.pushNamed(
          TranslationScreenWidget.routeName,
          extra: <String, dynamic>{
            kTransitionInfoKey: TransitionInfo(
              hasTransition: true,
              transitionType: PageTransitionType.rightToLeft,
            ),
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5D4B1),
                  borderRadius: BorderRadius.circular(1000.0),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Language Translation',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Gilroy',
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                        ),
                  ),
                  Text(
                    'Translate between languages',
                    style: FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Gilroy',
                          letterSpacing: 0.0,
                        ),
                  ),
                ].divide(const SizedBox(height: 4.0)),
              ),
            ].divide(const SizedBox(width: 12.0)),
          ),
        ),
      ),
    );
  }
}

