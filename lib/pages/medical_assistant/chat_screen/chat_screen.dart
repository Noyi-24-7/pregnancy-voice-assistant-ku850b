import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/comp_cont/voice_message_bubble/voice_message_bubble_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class ChatScreenWidget extends StatefulWidget {
  const ChatScreenWidget({super.key});

  static const String routeName = 'ChatScreen';
  static const String routePath = '/chatScreen';

  @override
  State<ChatScreenWidget> createState() => _ChatScreenWidgetState();
}

class _ChatScreenWidgetState extends State<ChatScreenWidget> {
  List<ChatMessageStruct> messages = [];
  bool isRecording = false;
  bool isProcessing = false;
  ScrollController? listViewController;
  AudioRecorder? audioRecorder;
  String? recordedAudioPath;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String? audioBase64;
  String? currentHistory;
  ApiCallResponse? apiResponse;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void addToMessages(ChatMessageStruct item) {
    setState(() {
      messages.add(item);
    });
  }

  @override
  void initState() {
    super.initState();
    listViewController = ScrollController();
  }

  @override
  void dispose() {
    listViewController?.dispose();
    audioRecorder?.dispose();
    super.dispose();
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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const _HeaderSection(),
              Expanded(
                child: messages.isNotEmpty
                    ? _MessagesList(
                        messages: messages,
                        listViewController: listViewController,
                      )
                    : const _EmptyStateSection(),
              ),
              _RecordingSection(
                isRecording: isRecording,
                isProcessing: isProcessing,
                onRecordTap: () async {
                  if (isRecording == false) {
                    await requestPermission(microphonePermission);
                    setState(() {
                      isRecording = true;
                    });
                    audioRecorder ??= AudioRecorder();
                    await startAudioRecording(
                      context,
                      audioRecorder: audioRecorder!,
                    );

                    HapticFeedback.lightImpact();
                  } else {
                    await stopAudioRecording(
                      audioRecorder: audioRecorder,
                      audioName: 'recordedFileBytes',
                      onRecordingComplete: (audioFilePath, audioBytes) {
                        recordedAudioPath = audioFilePath;
                        recordedFileBytes = audioBytes;
                      },
                    );

                    setState(() {
                      isRecording = false;
                      isProcessing = true;
                    });
                    HapticFeedback.mediumImpact();
                    audioBase64 = await actions.audioToBase64(
                      recordedAudioPath!,
                    );
                    await actions.getCurrentVitalsREST('', '');
                    currentHistory = await actions.formatMessagesForAPI(
                      messages.toList(),
                    );
                    apiResponse = await PregnancyAssistantCall.call(
                      audioFile: audioBase64!,
                      sourceLanguage: FFAppState().selectedLanguage,
                      targetLanguage: FFAppState().selectedLanguage,
                      conversationHistory: currentHistory!,
                    );

                    if ((apiResponse?.succeeded ?? true)) {
                      addToMessages(ChatMessageStruct(
                        text: getJsonField(
                          (apiResponse?.jsonBody ?? ''),
                          r'''$.result.transcribedText''',
                        ).toString(),
                        audioUrl: '\"\"',
                        isUser: true,
                        timestamp: getCurrentTimestamp,
                      ));
                      await Future.delayed(const Duration(milliseconds: 1500));
                      addToMessages(ChatMessageStruct(
                        text: getJsonField(
                          (apiResponse?.jsonBody ?? ''),
                          r'''$.result.translatedText''',
                        ).toString(),
                        audioUrl: getJsonField(
                          (apiResponse?.jsonBody ?? ''),
                          r'''$.result.audioUrl.publicUrl''',
                        ).toString(),
                        isUser: false,
                        timestamp: getCurrentTimestamp,
                      ));
                      setState(() {
                        isProcessing = false;
                      });
                      await listViewController?.animateTo(
                        listViewController!.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    } else {
                      await showDialog(
                        context: context,
                        builder: (alertDialogContext) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text(
                                'Unable to process your question. Please try again.'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(alertDialogContext),
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
                  }

                  if (mounted) {
                    setState(() {});
                  }
                },
              ),
            ],
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
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).primary,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 20.0, 16.0, 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed(HomeScreenWidget.routeName);
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    Icons.chevron_left_rounded,
                    color: FlutterFlowTheme.of(context).info,
                    size: 24.0,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Medical Assistant',
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              fontFamily: 'Gilroy',
                              letterSpacing: 0.0,
                              lineHeight: 1.3,
                            ),
                      ),
                      Text(
                        'Language - ${valueOrDefault<String>(
                          FFAppState().selectedLanguageName,
                          'English',
                        )}',
                        style: FlutterFlowTheme.of(context)
                            .titleSmall
                            .override(
                              fontFamily: 'Gilroy',
                              letterSpacing: 0.0,
                            ),
                      ),
                    ].divide(const SizedBox(height: 4.0)),
                  ),
                ].divide(const SizedBox(width: 8.0)),
              ),
            ),
            const SizedBox(width: 36.0, height: 36.0),
          ],
        ),
      ),
    );
  }
}

class _MessagesList extends StatelessWidget {
  const _MessagesList({
    required this.messages,
    required this.listViewController,
  });

  final List<ChatMessageStruct> messages;
  final ScrollController? listViewController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: messages.length,
          controller: listViewController,
          itemBuilder: (context, index) {
            final messageItem = messages[index];
            return VoiceMessageBubbleWidget(
              key: Key('Keyyrc_${index}_of_${messages.length}'),
              isUser: messageItem.isUser,
              audioUrl: messageItem.audioUrl,
              timestamp: messageItem.timestamp!,
            );
          },
        ),
      ),
    );
  }
}

class _EmptyStateSection extends StatelessWidget {
  const _EmptyStateSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
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
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(51.0, 0.0, 51.0, 0.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      36.0, 0.0, 36.0, 0.0),
                  child: Text(
                    valueOrDefault<String>(
                      functions.getEmptyStateText(
                          FFAppState().selectedLanguage, 'welcome'),
                      'WELCOME TO YOUR MEDICAL ASSISTANT',
                    ),
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Clash Grotesk',
                          letterSpacing: 0.0,
                          lineHeight: 1.2,
                        ),
                  ),
                ),
                Text(
                  valueOrDefault<String>(
                    functions.getEmptyStateText(
                        FFAppState().selectedLanguage, 'instruction'),
                    'Ask any health question in English',
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.0,
                        lineHeight: 1.5,
                      ),
                ),
              ].divide(const SizedBox(height: 4.0)),
            ),
          ),
        ].divide(const SizedBox(height: 16.0)),
      ),
    );
  }
}

class _RecordingSection extends StatelessWidget {
  const _RecordingSection({
    required this.isRecording,
    required this.isProcessing,
    required this.onRecordTap,
  });

  final bool isRecording;
  final bool isProcessing;
  final VoidCallback onRecordTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).micContainerBackground,
        boxShadow: const [
          BoxShadow(
            blurRadius: 8.0,
            color: Color(0x0B000000),
            offset: Offset(0.0, -2.0),
            spreadRadius: 2.0,
          )
        ],
        border: Border.all(
          color: FlutterFlowTheme.of(context).accent4,
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            valueOrDefault<String>(
              functions.getRecordingText(FFAppState().selectedLanguage, () {
                if (isProcessing == true) {
                  return 'processing';
                } else if (isRecording == true) {
                  return 'listening';
                } else {
                  return 'tap';
                }
              }()),
              'Tap to record a voice message',
            ),
            style: FlutterFlowTheme.of(context).labelLarge.override(
                  fontFamily: 'Gilroy',
                  letterSpacing: 0.0,
                ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: onRecordTap,
            child: Container(
              width: 136.0,
              height: 136.0,
              decoration: BoxDecoration(
                color: () {
                  if (isRecording == false) {
                    return FlutterFlowTheme.of(context).primary;
                  } else if (isRecording == true) {
                    return FlutterFlowTheme.of(context).tertiary;
                  } else {
                    return FlutterFlowTheme.of(context).info;
                  }
                }(),
                borderRadius: BorderRadius.circular(1000.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isRecording == false)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/adwiu_.png',
                        width: 48.0,
                        height: 48.0,
                        fit: BoxFit.contain,
                      ),
                    ),
                  if (isRecording == true)
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).info,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  if (isProcessing == true)
                    CircularPercentIndicator(
                      percent: 1.0,
                      radius: 16.0,
                      lineWidth: 8.0,
                      animation: true,
                      animateFromLastPercent: true,
                      progressColor: FlutterFlowTheme.of(context).primary,
                      backgroundColor: FlutterFlowTheme.of(context).accent4,
                      startAngle: 16.0,
                    ),
                ],
              ),
            ),
          ),
        ].divide(const SizedBox(height: 16.0)),
      ),
    );
  }
}

