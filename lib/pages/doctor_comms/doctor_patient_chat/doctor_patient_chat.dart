import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/comp_cont/voice_message_bubble_doc/voice_message_bubble_doc_widget.dart';
import '/comp_cont/voice_message_bubble_patient/voice_message_bubble_patient_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/flutter_flow/permissions_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class DoctorPatientChatWidget extends StatefulWidget {
  const DoctorPatientChatWidget({super.key});

  static const String routeName = 'DoctorPatientChat';
  static const String routePath = '/doctorPatientChat';

  @override
  State<DoctorPatientChatWidget> createState() =>
      _DoctorPatientChatWidgetState();
}

class _DoctorPatientChatWidgetState extends State<DoctorPatientChatWidget> {
  List<ChatMessageStruct> messages = [];
  bool isRecording = false;
  bool isProcessing = false;
  String currentThreadId = '\"temp_thread\"';
  bool includeVitals = false;
  int messageCount = 0;
  bool pollingActive = false;
  String? uploadedAudioUrl;
  String? translatedText;
  String? currentVitalsJson;
  List<dynamic> parsedCurrentMessage = [];
  String? originalText;
  int? nowMs;
  String? normPid;
  ApiCallResponse? assignmentBody;
  String? threadIdVal;
  ApiCallResponse? msgBody;
  String? msgsJson;
  List<dynamic>? msgsList;
  List<dynamic>? emptyList;
  ScrollController? listViewController;
  AudioRecorder? audioRecorder;
  String? recStop;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');
  String? b64Audio;
  ApiCallResponse? transText;
  ApiCallResponse? savePatient;
  ApiCallResponse? update;
  ApiCallResponse? loadMsgs;
  String? normalizedJson;
  List<dynamic>? parsedList;
  List<dynamic>? empty;
  bool? checkboxValue;
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
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().currentPatientId = currentPhoneNumber;
      if (mounted) {
        setState(() {});
      }
      normPid = await actions.normalizePatientId(
        FFAppState().currentPatientId,
      );
      assignmentBody = await GetAssignedDoctorCall.call(
        patientKey: normPid!,
      );

      if ((assignmentBody?.succeeded ?? true)) {
        FFAppState().assignedDoctorId = getJsonField(
          (assignmentBody?.jsonBody ?? ''),
          r'''$.doctorId''',
        ).toString();
        FFAppState().selectedLanguage = valueOrDefault<String>(
          getJsonField(
            FFAppState().currentPatientData,
            r'''$.profile.language''',
          )?.toString(),
          'English',
        );
        if (mounted) {
          setState(() {});
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Couldn't find assigned doctor.',
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
        context.safePop();
      }

      threadIdVal = await actions.buildThreadIdAct(
        normPid!,
        FFAppState().assignedDoctorId,
      );
      currentThreadId = threadIdVal!;
      if (mounted) {
        setState(() {});
      }
      msgBody = await GetThreadMessagesCall.call(
        threadId: currentThreadId,
      );

      if ((msgBody?.succeeded ?? true)) {
        msgsJson = await actions.buildMessagesForUI(
          (msgBody?.bodyText ?? ''),
        );
        msgsList = await actions.parseJsonToList(msgsJson!);
        parsedCurrentMessage = msgsList!.toList().cast<dynamic>();
        if (mounted) {
          setState(() {});
        }
      } else {
        emptyList = await actions.parseJsonToList('[]');
        parsedCurrentMessage = emptyList!.toList().cast<dynamic>();
        if (mounted) {
          setState(() {});
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'No messages yet.',
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
                child: parsedCurrentMessage.isNotEmpty
                    ? _MessagesList(
                        messages: parsedCurrentMessage,
                        listViewController: listViewController,
                      )
                    : const _EmptyStateSection(),
              ),
              _RecordingSection(
                isRecording: isRecording,
                isProcessing: isProcessing,
                includeVitals: checkboxValue ?? includeVitals,
                onRecordTap: () async {
                  if (isRecording == false) {
                    await requestPermission(microphonePermission);
                    audioRecorder ??= AudioRecorder();
                    await startAudioRecording(
                      context,
                      audioRecorder: audioRecorder!,
                    );

                    setState(() {
                      isRecording = true;
                    });
                    HapticFeedback.lightImpact();
                  } else {
                    await stopAudioRecording(
                      audioRecorder: audioRecorder,
                      audioName: 'recordedFileBytes',
                      onRecordingComplete: (audioFilePath, audioBytes) {
                        recStop = audioFilePath;
                        recordedFileBytes = audioBytes;
                      },
                    );

                    setState(() {
                      isRecording = false;
                      isProcessing = true;
                    });
                    b64Audio = await actions.audioToBase64(recStop!);
                    nowMs = getCurrentTimestamp.millisecondsSinceEpoch;
                    if (mounted) {
                      setState(() {});
                    }
                    transText = await TranslateVoiceCall.call(
                      audioFile: b64Audio!,
                      sourceLanguage: FFAppState().selectedLanguage,
                      targetLanguage: 'en',
                    );

                    if ((transText?.succeeded ?? true)) {
                      translatedText = getJsonField(
                        (transText?.jsonBody ?? ''),
                        r'''$.result.finalText''',
                      ).toString();
                      if (mounted) {
                        setState(() {});
                      }
                      savePatient = await SavePatientMessageCall.call(
                        threadId: currentThreadId,
                        text: translatedText!,
                        audioUrl: getJsonField(
                          (transText?.jsonBody ?? ''),
                          r'''$.result.audioUrl.publicUrl''',
                        ).toString(),
                        sender: 'patient',
                        language: FFAppState().selectedLanguage,
                        createdAt: nowMs?.toString(),
                      );

                      if ((savePatient?.succeeded ?? true)) {
                        update = await UpdateThreadCall.call(
                          lastMessageAt: nowMs?.toString(),
                          lastMessagePreview: translatedText!,
                          status: 'active',
                        );

                        if ((update?.succeeded ?? true)) {
                          loadMsgs = await LoadMessagesCall.call(
                            threadId: currentThreadId,
                          );

                          if ((loadMsgs?.succeeded ?? true)) {
                            normalizedJson = await actions.buildMessagesForUI(
                              (loadMsgs?.bodyText ?? ''),
                            );
                            parsedList = await actions.parseJsonToList(
                              normalizedJson!,
                            );
                            parsedCurrentMessage =
                                parsedList!.toList().cast<dynamic>();
                            if (mounted) {
                              setState(() {});
                            }
                            await listViewController?.animateTo(
                              listViewController!.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.ease,
                            );
                            setState(() {
                              isProcessing = false;
                            });
                          } else {
                            empty = await actions.parseJsonToList('[]');
                            parsedCurrentMessage =
                                empty!.toList().cast<dynamic>();
                            if (mounted) {
                              setState(() {});
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Couldn't load messages.',
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
                        } else {
                          setState(() {
                            isProcessing = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Error During Update',
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
                      } else {
                        setState(() {
                          isProcessing = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Error During Save',
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
                    } else {
                      setState(() {
                        isProcessing = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Error, Failed to Translate',
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
                  }

                  if (mounted) {
                    setState(() {});
                  }
                },
                onVitalsCheckboxChanged: (newValue) {
                  setState(() {
                    checkboxValue = newValue;
                    includeVitals = newValue;
                  });
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
                        'Contact Doctor',
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
                          getJsonField(
                            FFAppState().currentPatientData,
                            r'''$.profile.language''',
                          )?.toString(),
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

  final List<dynamic> messages;
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
            if (getJsonField(messageItem, r'''$.doctorFlag''') != null) {
              return VoiceMessageBubbleDocWidget(
                key: Key('Keytaj_${index}_of_${messages.length}'),
                messageData: getJsonField(messageItem, r'''$'''),
              );
            } else {
              return VoiceMessageBubblePatientWidget(
                key: Key('Keybzi_${index}_of_${messages.length}'),
                messageData: getJsonField(messageItem, r'''$'''),
              );
            }
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
                  padding: const EdgeInsetsDirectional.fromSTEB(32.0, 0.0, 32.0, 0.0),
                  child: Text(
                    'Talk to Your Assigned Doctor',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'Clash Grotesk',
                          letterSpacing: 0.0,
                          lineHeight: 1.2,
                        ),
                  ),
                ),
                Text(
                  'No messages yet',
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
    required this.includeVitals,
    required this.onRecordTap,
    required this.onVitalsCheckboxChanged,
  });

  final bool isRecording;
  final bool isProcessing;
  final bool includeVitals;
  final VoidCallback onRecordTap;
  final ValueChanged<bool> onVitalsCheckboxChanged;

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
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theme(
                  data: ThemeData(
                    checkboxTheme: CheckboxThemeData(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    unselectedWidgetColor:
                        FlutterFlowTheme.of(context).micStroke,
                  ),
                  child: Checkbox(
                    value: includeVitals,
                    onChanged: (newValue) {
                      onVitalsCheckboxChanged(newValue ?? false);
                    },
                    side: (FlutterFlowTheme.of(context).micStroke != null)
                        ? BorderSide(
                            width: 2,
                            color: FlutterFlowTheme.of(context).micStroke!,
                          )
                        : null,
                    activeColor: FlutterFlowTheme.of(context).primary,
                    checkColor: FlutterFlowTheme.of(context).info,
                  ),
                ),
                Text(
                  'Include current vitals with message',
                  style: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Gilroy',
                        letterSpacing: 0.0,
                      ),
                ),
              ].divide(const SizedBox(width: 4.0)),
            ),
          ),
        ].divide(const SizedBox(height: 16.0)),
      ),
    );
  }
}

