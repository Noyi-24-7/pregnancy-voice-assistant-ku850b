import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_audio_player.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class TranslationScreenWidget extends StatefulWidget {
  const TranslationScreenWidget({super.key});

  static const String routeName = 'TranslationScreen';
  static const String routePath = '/translationScreen';

  @override
  State<TranslationScreenWidget> createState() =>
      _TranslationScreenWidgetState();
}

class _TranslationScreenWidgetState extends State<TranslationScreenWidget> {
  String? transcribedText;
  String? translatedText;
  String? audioUrl =
      'https://storage.googleapis.com/buildship-1pz4ke-us-central1/voice-translations/output/translation-1754378489422.m4a';
  bool isProcessing = false;
  bool isRecording = false;
  String? sourceLanguageDropdownValue = 'en';
  FormFieldController<String>? sourceLanguageDropdownValueController;
  String? targetLanguageDropdownValue = 'yo';
  FormFieldController<String>? targetLanguageDropdownValueController;
  String? recordedAudio;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String? audioBase64;
  ApiCallResponse? apiResultf49;
  AudioRecorder? audioRecorder;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    audioRecorder?.dispose();
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (isProcessing) {
              await stopAudioRecording(
                audioRecorder: audioRecorder,
                audioName: 'recordedFileBytes',
                onRecordingComplete: (audioFilePath, audioBytes) {
                  recordedAudio = audioFilePath;
                  recordedFileBytes = audioBytes;
                },
              );

              await Future.delayed(const Duration(milliseconds: 500));
              setState(() {
                isRecording = false;
              });
              audioBase64 = await actions.audioToBase64(recordedAudio!);
              setState(() {
                isProcessing = false;
              });
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Processing translation...',
                    style: GoogleFonts.robotoCondensed(
                      color: FlutterFlowTheme.of(context).info,
                    ),
                  ),
                  duration: const Duration(milliseconds: 4000),
                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                ),
              );
              apiResultf49 = await TranslateVoiceCall.call(
                audioFile: audioBase64!,
                sourceLanguage: sourceLanguageDropdownValue!,
                targetLanguage: targetLanguageDropdownValue!,
              );

              if ((apiResultf49?.succeeded ?? true)) {
                transcribedText = getJsonField(
                  (apiResultf49?.jsonBody ?? ''),
                  r'''$.result.transcribedText''',
                ).toString();
                translatedText = getJsonField(
                  (apiResultf49?.jsonBody ?? ''),
                  r'''$.result.translatedText''',
                ).toString();
                audioUrl = getJsonField(
                  (apiResultf49?.jsonBody ?? ''),
                  r'''$.result.audioUrl.publicUrl''',
                ).toString();
                setState(() {
                  isProcessing = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      getJsonField(
                        (apiResultf49?.jsonBody ?? ''),
                        r'''$.result.audioUrl.publicUrl''',
                      ).toString(),
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
              } else {
                await showDialog(
                  context: context,
                  builder: (alertDialogContext) {
                    return AlertDialog(
                      title: const Text('Translation Failed'),
                      content: const Text(
                          'Unable to process audio. Please try again.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(alertDialogContext),
                          child: const Text('Ok'),
                        ),
                      ],
                    );
                  },
                );
                setState(() {
                  isProcessing = false;
                });
              }
            } else {
              await requestPermission(microphonePermission);
              setState(() {
                isProcessing = true;
              });
              audioRecorder ??= AudioRecorder();
              await startAudioRecording(
                context,
                audioRecorder: audioRecorder!,
              );

              setState(() {
                isRecording = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Recording... Release to stop',
                    style: GoogleFonts.robotoCondensed(
                      color: FlutterFlowTheme.of(context).info,
                      fontSize: 14.0,
                    ),
                  ),
                  duration: const Duration(milliseconds: 10000),
                  backgroundColor: FlutterFlowTheme.of(context).secondary,
                ),
              );
            }

            if (mounted) {
              setState(() {});
            }
          },
          backgroundColor: () {
            if (isRecording == true) {
              return FlutterFlowTheme.of(context).darkMutedColor;
            } else if (isRecording == false) {
              return FlutterFlowTheme.of(context).warning;
            } else {
              return FlutterFlowTheme.of(context).secondary;
            }
          }(),
          elevation: 8.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isRecording == false)
                Icon(
                  Icons.mic,
                  color: FlutterFlowTheme.of(context).info,
                  size: 24.0,
                ),
              if (isRecording == true)
                Container(
                  width: 16.0,
                  height: 16.0,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).warning,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () async {
              context.pop();
            },
          ),
          title: Text(
            'Voice Translator',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Clash Grotesk',
                  color: Colors.white,
                  fontSize: 22.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _LanguageSelectorSection(
                  sourceLanguageDropdownValue: sourceLanguageDropdownValue,
                  sourceLanguageDropdownValueController:
                      sourceLanguageDropdownValueController,
                  onSourceLanguageChanged: (val) {
                    setState(() {
                      sourceLanguageDropdownValue = val;
                    });
                  },
                  targetLanguageDropdownValue: targetLanguageDropdownValue,
                  targetLanguageDropdownValueController:
                      targetLanguageDropdownValueController,
                  onTargetLanguageChanged: (val) {
                    setState(() {
                      targetLanguageDropdownValue = val;
                    });
                  },
                ),
                _TranslationResultSection(
                  isRecording: isRecording,
                  isProcessing: isProcessing,
                  translatedText: translatedText,
                  audioUrl: audioUrl,
                  targetLanguageDropdownValue: targetLanguageDropdownValue,
                ),
                if ((isProcessing == true) &&
                    (audioUrl == null || audioUrl == ''))
                  _ProcessingIndicator(),
              ].divide(const SizedBox(height: 24.0)),
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageSelectorSection extends StatelessWidget {
  const _LanguageSelectorSection({
    required this.sourceLanguageDropdownValue,
    required this.sourceLanguageDropdownValueController,
    required this.onSourceLanguageChanged,
    required this.targetLanguageDropdownValue,
    required this.targetLanguageDropdownValueController,
    required this.onTargetLanguageChanged,
  });

  final String? sourceLanguageDropdownValue;
  final FormFieldController<String>? sourceLanguageDropdownValueController;
  final ValueChanged<String?> onSourceLanguageChanged;
  final String? targetLanguageDropdownValue;
  final FormFieldController<String>? targetLanguageDropdownValueController;
  final ValueChanged<String?> onTargetLanguageChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).aiChatBubble,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              width: 0.0,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 16.0, 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'From',
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.0,
                      ),
                ),
                FlutterFlowDropDown<String>(
                  controller: sourceLanguageDropdownValueController ??
                      FormFieldController<String>(sourceLanguageDropdownValue ?? 'en'),
                  options: const ['en', 'yo', 'ha', 'ig'],
                  optionLabels: const ['English', 'Yoruba', 'Hausa', 'Igbo'],
                  onChanged: onSourceLanguageChanged,
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
              ].divide(const SizedBox(width: 16.0)),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).aiChatBubble,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
          ),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(24.0, 12.0, 16.0, 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'To',
                  style: FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.0,
                      ),
                ),
                FlutterFlowDropDown<String>(
                  controller: targetLanguageDropdownValueController ??
                      FormFieldController<String>(targetLanguageDropdownValue ?? 'yo'),
                  options: const ['en', 'yo', 'ha', 'ig'],
                  optionLabels: const ['English', 'Yoruba', 'Hausa', 'Igbo'],
                  onChanged: onTargetLanguageChanged,
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
              ].divide(const SizedBox(width: 16.0)),
            ),
          ),
        ),
      ],
    );
  }
}

class _TranslationResultSection extends StatelessWidget {
  const _TranslationResultSection({
    required this.isRecording,
    required this.isProcessing,
    required this.translatedText,
    required this.audioUrl,
    required this.targetLanguageDropdownValue,
  });

  final bool isRecording;
  final bool isProcessing;
  final String? translatedText;
  final String? audioUrl;
  final String? targetLanguageDropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 200.0),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).aiChatBubble,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              () {
                if (isRecording == false) {
                  return 'Tap Mic Button to Record';
                } else if (isRecording == true) {
                  return 'Listening, Tap Again to Stop';
                } else if (isProcessing == true) {
                  return 'AI Processing Response';
                } else {
                  return 'Tap Mic Button to Record';
                }
              }(),
              style: FlutterFlowTheme.of(context).labelMedium.override(
                    fontFamily: 'Gilroy',
                    letterSpacing: 0.0,
                  ),
            ),
            Text(
              valueOrDefault<String>(
                translatedText,
                'Translation will appear here',
              ),
              style: FlutterFlowTheme.of(context).bodyLarge.override(
                    fontFamily: 'Gilroy',
                    letterSpacing: 0.0,
                  ),
            ),
            FlutterFlowAudioPlayer(
              audio: Audio.network(
                functions.stringToAudioPath(audioUrl)!,
                metas: Metas(
                  title: targetLanguageDropdownValue,
                ),
              ),
              titleTextStyle:
                  FlutterFlowTheme.of(context).titleLarge.override(
                        fontFamily: 'Clash Grotesk',
                        fontSize: 0.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                      ),
              playbackDurationTextStyle:
                  FlutterFlowTheme.of(context).labelMedium.override(
                        fontFamily: 'Gilroy',
                        fontSize: 14.0,
                        letterSpacing: 0.0,
                      ),
              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
              playbackButtonColor: FlutterFlowTheme.of(context).warning,
              activeTrackColor: FlutterFlowTheme.of(context).warning,
              inactiveTrackColor: FlutterFlowTheme.of(context).alternate,
              elevation: 0.0,
              playInBackground: PlayInBackground.disabledRestoreOnForeground,
            ),
          ].divide(const SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}

class _ProcessingIndicator extends StatelessWidget {
  const _ProcessingIndicator();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0),
          bottomRight: Radius.circular(40.0),
          topLeft: Radius.zero,
          topRight: Radius.zero,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Lottie.asset(
            'assets/jsons/Animation_-_1749020114150.json',
            width: 100.0,
            height: 100.0,
            fit: BoxFit.contain,
            animate: true,
          ),
          Text(
            'Processing...',
            style: FlutterFlowTheme.of(context).labelLarge.override(
                  fontFamily: 'Gilroy',
                  letterSpacing: 0.0,
                ),
          ),
        ],
      ),
    );
  }
}

