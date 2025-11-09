import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_audio_player.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class ArticleDetailScreenWidget extends StatefulWidget {
  const ArticleDetailScreenWidget({
    super.key,
    required this.article,
  });

  final EducationalArticleStruct? article;

  static const String routeName = 'ArticleDetailScreen';
  static const String routePath = '/articleDetailScreen';

  @override
  State<ArticleDetailScreenWidget> createState() =>
      _ArticleDetailScreenWidgetState();
}

class _ArticleDetailScreenWidgetState
    extends State<ArticleDetailScreenWidget> {
  String? translatedContent = '';
  String? audioUrl = '';
  bool isGeneratingAudio = false;
  String selectedLanguage = 'en';
  bool isTranslating = false;
  String? translatedTitle;
  bool canViewAudio = false;
  String? languageDropdownValue;
  FormFieldController<String>? languageDropdownValueController;
  String? articleJsonString;
  ApiCallResponse? translationResponse;
  dynamic? extractedData;
  String? audioArticleJson;
  ApiCallResponse? audioResponse;
  String? extractedAudioUrl;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      translatedContent = widget.article?.content;
      translatedTitle = valueOrDefault<String>(
        widget.article?.title,
        '11 safety tips for your baby\'s nursery',
      );
      if (mounted) {
        setState(() {});
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const _HeaderSection(),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      height: 640.0,
                      decoration: const BoxDecoration(),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _LanguageSelectorSection(
                              languageDropdownValue: languageDropdownValue,
                              languageDropdownValueController:
                                  languageDropdownValueController,
                              onLanguageChanged: (val) async {
                                setState(() {
                                  languageDropdownValue = val;
                                  selectedLanguage = languageDropdownValue!;
                                });
                                if ((languageDropdownValue != 'en') ||
                                    (languageDropdownValue == 'en')) {
                                  setState(() {
                                    isGeneratingAudio = true;
                                    isTranslating = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Translating article...',
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
                                  articleJsonString =
                                      await actions.prepareArticleForAudio(
                                    widget.article!.toMap(),
                                    'null',
                                    'null',
                                  );
                                  translationResponse =
                                      await ContentProcessorAPICall.call(
                                    articlesJson: articleJsonString!,
                                    targetLanguage: languageDropdownValue!,
                                    action: 'translate_only',
                                    articleId: widget.article?.id,
                                  );

                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  if ((translationResponse?.succeeded ?? true)) {
                                    extractedData =
                                        await actions.extractTranslatedData(
                                      (translationResponse?.jsonBody ?? ''),
                                    );
                                    translatedContent = getJsonField(
                                      extractedData,
                                      r'''$.translatedContent''',
                                    ).toString();
                                    translatedTitle = getJsonField(
                                      extractedData,
                                      r'''$.translatedTitle''',
                                    ).toString();
                                    setState(() {
                                      isTranslating = false;
                                      isGeneratingAudio = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Translation complete!',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyLarge
                                              .override(
                                                fontFamily: 'Gilroy',
                                                color: FlutterFlowTheme.of(context)
                                                    .primaryText,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                        duration: const Duration(milliseconds: 1000),
                                        backgroundColor: FlutterFlowTheme.of(context)
                                            .micContainerBackground,
                                      ),
                                    );
                                    setState(() {
                                      canViewAudio = false;
                                    });
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Translation failed. Please try again.',
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
                                    setState(() {
                                      isGeneratingAudio = false;
                                      isTranslating = false;
                                    });
                                  }
                                }

                                if (mounted) {
                                  setState(() {});
                                }
                              },
                            ),
                            _ArticleContentSection(
                              article: widget.article,
                              translatedTitle: translatedTitle,
                              translatedContent: translatedContent,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 1.0),
                      child: _AudioPlayerSection(
                        canViewAudio: canViewAudio,
                        audioUrl: audioUrl,
                        isGeneratingAudio: isGeneratingAudio,
                        onGenerateAudio: () async {
                          if (isGeneratingAudio == false) {
                            setState(() {
                              isGeneratingAudio = true;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Generating audio...',
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
                            audioArticleJson =
                                await actions.prepareArticleForAudio(
                              widget.article!.toMap(),
                              translatedContent,
                              translatedTitle,
                            );
                            audioResponse = await ContentProcessorAPICall.call(
                              articlesJson: articleJsonString!,
                              targetLanguage: selectedLanguage,
                              action: 'translate_and_audio',
                              articleId: widget.article?.id,
                            );

                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            if ((audioResponse?.succeeded ?? true)) {
                              extractedAudioUrl = await actions.extractAudioUrl(
                                getJsonField(
                                  (audioResponse?.jsonBody ?? ''),
                                  r'''$.articles[:].audioUrl''',
                                ),
                              );
                              audioUrl = getJsonField(
                                (audioResponse?.jsonBody ?? ''),
                                r'''$.articles[:].audioUrl''',
                              ).toString();
                              setState(() {
                                isGeneratingAudio = false;
                                canViewAudio = true;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Audio ready! Press play to listen',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'Gilroy',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                  duration: const Duration(milliseconds: 2000),
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .micContainerBackground,
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Failed to generate audio from translated text',
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
                              setState(() {
                                isGeneratingAudio = false;
                              });
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Audio generation in progress...',
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

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        border: Border.all(
          color: FlutterFlowTheme.of(context).micStroke,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 56.0, 0.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.close_rounded,
                color: FlutterFlowTheme.of(context).darkMutedColor,
                size: 30.0,
              ),
              onPressed: () async {
                context.pop();
              },
            ),
            Text(
              'Insights',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Clash Grotesk',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 18.0,
                    letterSpacing: 0.0,
                  ),
            ),
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 30.0,
              borderWidth: 1.0,
              buttonSize: 60.0,
              icon: Icon(
                Icons.bookmark_border_outlined,
                color: FlutterFlowTheme.of(context).darkMutedColor,
                size: 30.0,
              ),
              onPressed: () async {
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageSelectorSection extends StatelessWidget {
  const _LanguageSelectorSection({
    required this.languageDropdownValue,
    required this.languageDropdownValueController,
    required this.onLanguageChanged,
  });

  final String? languageDropdownValue;
  final FormFieldController<String>? languageDropdownValueController;
  final ValueChanged<String?> onLanguageChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24.0, 28.0, 16.0, 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Language:',
                  style: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.0,
                      ),
                ),
                Expanded(
                  child: FlutterFlowDropDown<String>(
                    controller: languageDropdownValueController ??
                        FormFieldController<String>(null),
                    options: const ['en', 'yo', 'ha', 'ig'],
                    optionLabels: const [
                      'English',
                      'Yoruba',
                      'Hausa',
                      'Igbo'
                    ],
                    onChanged: onLanguageChanged,
                    width: 200.0,
                    height: 56.0,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Gilroy',
                          letterSpacing: 0.0,
                        ),
                    hintText: 'Select...',
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    fillColor: FlutterFlowTheme.of(context).micContainerBackground,
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
                ),
              ].divide(const SizedBox(width: 16.0)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArticleContentSection extends StatelessWidget {
  const _ArticleContentSection({
    required this.article,
    required this.translatedTitle,
    required this.translatedContent,
  });

  final EducationalArticleStruct? article;
  final String? translatedTitle;
  final String? translatedContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  valueOrDefault<String>(
                    translatedTitle != null && translatedTitle != ''
                        ? translatedTitle
                        : valueOrDefault<String>(
                            article?.title,
                            '11 safety tips for your baby\'s nursery',
                          ),
                    '11 safety tips for your baby\'s nursery',
                  ),
                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'Clash Grotesk',
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0.0,
                      ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://picsum.photos/seed/548/600',
                        width: 40.0,
                        height: 40.0,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox(width: 40.0, height: 40.0),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Written By',
                          style: FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Gilroy',
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                              ),
                        ),
                        Text(
                          valueOrDefault<String>(
                            article?.author,
                            'Dr Jenna Beckham',
                          ),
                          style: FlutterFlowTheme.of(context).bodyLarge.override(
                                fontFamily: 'Gilroy',
                                fontSize: 14.0,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ].divide(const SizedBox(height: 4.0)),
                    ),
                  ].divide(const SizedBox(width: 12.0)),
                ),
              ].divide(const SizedBox(height: 16.0)),
            ),
            if (article?.imageUrl != null && article?.imageUrl != '')
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      article!.imageUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(width: double.infinity, height: 200.0),
                    ),
                  ),
                ),
              )
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  width: double.infinity,
                  height: 200.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).primaryBackground,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    child: Text(
                      valueOrDefault<String>(
                        translatedContent != null && translatedContent != ''
                            ? translatedContent
                            : article?.content,
                        'Content that\'s been translated...',
                      ),
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                            fontFamily: 'Gilroy',
                            letterSpacing: 0.0,
                            lineHeight: 1.5,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ].divide(const SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}

class _AudioPlayerSection extends StatelessWidget {
  const _AudioPlayerSection({
    required this.canViewAudio,
    required this.audioUrl,
    required this.isGeneratingAudio,
    required this.onGenerateAudio,
  });

  final bool canViewAudio;
  final String? audioUrl;
  final bool isGeneratingAudio;
  final VoidCallback onGenerateAudio;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).micContainerBackground,
        border: Border.all(
          color: FlutterFlowTheme.of(context).micStroke,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (canViewAudio == true)
              FlutterFlowAudioPlayer(
                audio: Audio.network(
                  functions.stringToAudioPath(audioUrl)!,
                  metas: Metas(
                    title: 'Listen to Article',
                  ),
                ),
                titleTextStyle:
                    FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Clash Grotesk',
                          letterSpacing: 0.0,
                        ),
                playbackDurationTextStyle:
                    FlutterFlowTheme.of(context).labelMedium.override(
                          fontFamily: 'Gilroy',
                          letterSpacing: 0.0,
                        ),
                fillColor: FlutterFlowTheme.of(context).micContainerBackground,
                playbackButtonColor: FlutterFlowTheme.of(context).primary,
                activeTrackColor: FlutterFlowTheme.of(context).primary,
                inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
                elevation: 0.0,
                playInBackground: PlayInBackground.disabledRestoreOnForeground,
              ),
            if (canViewAudio == false)
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Listen to Article',
                          style: FlutterFlowTheme.of(context).titleLarge.override(
                                fontFamily: 'Clash Grotesk',
                                color: FlutterFlowTheme.of(context).primary,
                                letterSpacing: 0.0,
                              ),
                        ),
                        Text(
                          'Audio in selected language',
                          style: FlutterFlowTheme.of(context).labelMedium.override(
                                fontFamily: 'Gilroy',
                                letterSpacing: 0.0,
                              ),
                        ),
                      ].divide(const SizedBox(height: 4.0)),
                    ),
                    if (isGeneratingAudio == true)
                      CircularPercentIndicator(
                        percent: 1.0,
                        radius: 12.0,
                        lineWidth: 4.0,
                        animation: true,
                        animateFromLastPercent: true,
                        progressColor: FlutterFlowTheme.of(context).primary,
                        backgroundColor: FlutterFlowTheme.of(context).accent4,
                      )
                    else
                      FlutterFlowIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30.0,
                        borderWidth: 1.0,
                        buttonSize: 60.0,
                        icon: Icon(
                          Icons.settings_sharp,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 30.0,
                        ),
                        onPressed: onGenerateAudio,
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

