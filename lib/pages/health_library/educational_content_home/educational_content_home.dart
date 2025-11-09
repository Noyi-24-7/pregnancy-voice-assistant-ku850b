import '/backend/api_requests/api_calls.dart';
import '/comp_cont/educational_article_card/educational_article_card_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/backend/schema/structs/index.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class EducationalContentHomeWidget extends StatefulWidget {
  const EducationalContentHomeWidget({super.key});

  static const String routeName = 'EducationalContentHome';
  static const String routePath = '/educationalContentHome';

  @override
  State<EducationalContentHomeWidget> createState() =>
      _EducationalContentHomeWidgetState();
}

class _EducationalContentHomeWidgetState
    extends State<EducationalContentHomeWidget> {
  String selectedCategory = 'all';
  List<dynamic> articles = [];
  bool isLoading = false;
  List<dynamic>? sampleContent;
  List<dynamic>? filteredArticlespCopy;
  ApiCallResponse? fetchResponse;
  String? articlesJsonString;
  ApiCallResponse? translateResponse;
  List<dynamic>? fallbackContent;
  List<dynamic>? filteredArticlesbCopy;
  ApiCallResponse? fetchResponseCopy;
  String? articlesJsonStringCopy;
  ApiCallResponse? translateResponseCopy;
  List<dynamic>? fallbackContentCopy;
  List<dynamic>? filteredArticlesn;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void addToArticles(dynamic item) {
    setState(() {
      articles.add(item);
    });
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().currentMode = 'education';
      if (mounted) {
        setState(() {});
      }
      sampleContent = await actions.getSampleEducationalContent();
      articles = sampleContent!.toList().cast<dynamic>();
      if (mounted) {
        setState(() {});
      }
      FFAppState().offlineContent =
          sampleContent!.toList().cast<dynamic>();
      if (mounted) {
        setState(() {});
      }
    });
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
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const _HeaderSection(),
                _TopicsSection(
                  onCategorySelected: (category) async {
                    setState(() {
                      isLoading = true;
                      selectedCategory = category;
                    });
                    if (category == 'pregnancy') {
                      fetchResponse = await ContentFetcherAPICall.call(
                        topic: 'pregnancy',
                        category: 'pregnancy',
                        language: 'en',
                      );

                      if ((fetchResponse?.succeeded ?? true)) {
                        if (FFAppState().educationalLanguage != 'en') {
                          articlesJsonString =
                              await actions.articlesToJsonString(
                            getJsonField(
                              (fetchResponse?.jsonBody ?? ''),
                              r'''$.articles''',
                              true,
                            )!,
                          );
                          translateResponse =
                              await ContentProcessorAPICall.call(
                            articlesJson: articlesJsonString!,
                            targetLanguage: FFAppState().educationalLanguage,
                            action: 'translate_only',
                            articleId: '\"\"',
                          );

                          if ((translateResponse?.succeeded ?? true)) {
                            articles = getJsonField(
                              (translateResponse?.jsonBody ?? ''),
                              r'''$.articles''',
                              true,
                            )!
                                .toList()
                                .cast<dynamic>();
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            articles = getJsonField(
                              (fetchResponse?.jsonBody ?? ''),
                              r'''$.articles''',
                              true,
                            )!
                                .toList()
                                .cast<dynamic>();
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Translation unavailable, showing English content',
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
                          articles = getJsonField(
                            (fetchResponse?.jsonBody ?? ''),
                            r'''$.articles''',
                            true,
                          )!
                              .toList()
                              .cast<dynamic>();
                          setState(() {
                            isLoading = false;
                          });
                        }
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Unable to load content. Please check your connection.',
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
                        fallbackContent =
                            await actions.getSampleEducationalContent();
                        articles = fallbackContent!.toList().cast<dynamic>();
                        if (mounted) {
                          setState(() {});
                        }
                      }
                    } else if (category == 'birth_control') {
                      fetchResponseCopy = await ContentFetcherAPICall.call(
                        topic: 'birth_control',
                        category: 'birth_control',
                        language: 'en',
                      );

                      if ((fetchResponseCopy?.succeeded ?? true)) {
                        if (FFAppState().educationalLanguage != 'en') {
                          articlesJsonStringCopy =
                              await actions.articlesToJsonString(
                            getJsonField(
                              (fetchResponseCopy?.jsonBody ?? ''),
                              r'''$.articles''',
                              true,
                            )!,
                          );
                          translateResponseCopy =
                              await ContentProcessorAPICall.call(
                            articlesJson: articlesJsonStringCopy!,
                            targetLanguage: FFAppState().educationalLanguage,
                            action: 'translate_only',
                            articleId: '\"\"',
                          );

                          if ((translateResponseCopy?.succeeded ?? true)) {
                            articles = getJsonField(
                              (translateResponseCopy?.jsonBody ?? ''),
                              r'''$.articles''',
                              true,
                            )!
                                .toList()
                                .cast<dynamic>();
                            setState(() {
                              isLoading = false;
                            });
                          } else {
                            articles = getJsonField(
                              (fetchResponseCopy?.jsonBody ?? ''),
                              r'''$.articles''',
                              true,
                            )!
                                .toList()
                                .cast<dynamic>();
                            setState(() {
                              isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Translation unavailable, showing English content',
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
                          articles = getJsonField(
                            (fetchResponseCopy?.jsonBody ?? ''),
                            r'''$.articles''',
                            true,
                          )!
                              .toList()
                              .cast<dynamic>();
                          setState(() {
                            isLoading = false;
                          });
                        }
                      } else {
                        setState(() {
                          isLoading = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Unable to load content. Please check your connection.',
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
                        fallbackContentCopy =
                            await actions.getSampleEducationalContent();
                        articles = fallbackContentCopy!.toList().cast<dynamic>();
                        if (mounted) {
                          setState(() {});
                        }
                      }
                    } else if (category == 'nutrition') {
                      await actions.getSampleEducationalContent();
                      articles = sampleContent!.toList().cast<dynamic>();
                      if (mounted) {
                        setState(() {});
                      }
                      setState(() {
                        selectedCategory = 'nutrition';
                      });
                      filteredArticlesn =
                          await actions.filterContentByCategory(
                        articles.toList(),
                        'nutrition',
                      );
                      articles = filteredArticlesn!.toList().cast<dynamic>();
                      if (mounted) {
                        setState(() {});
                      }
                    }

                    if (mounted) {
                      setState(() {});
                    }
                  },
                  onCategoryDoubleTapped: (category) async {
                    await actions.getSampleEducationalContent();
                    articles = sampleContent!.toList().cast<dynamic>();
                    if (mounted) {
                      setState(() {});
                    }
                    setState(() {
                      selectedCategory = category;
                    });
                    if (category == 'pregnancy') {
                      filteredArticlespCopy =
                          await actions.filterContentByCategory(
                        articles.toList(),
                        'pregnancy',
                      );
                      articles = filteredArticlespCopy!.toList().cast<dynamic>();
                    } else if (category == 'birth_control') {
                      filteredArticlesbCopy =
                          await actions.filterContentByCategory(
                        articles.toList(),
                        'birth_control',
                      );
                      articles = filteredArticlesbCopy!.toList().cast<dynamic>();
                    }
                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
                _ArticlesListSection(articles: articles),
              ]
                  .divide(const SizedBox(height: 16.0))
                  .addToEnd(const SizedBox(height: 40.0)),
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 56.0, 0.0, 0.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 60.0, height: 60.0),
            Text(
              'Health Library',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Clash Grotesk',
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 22.0,
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

class _TopicsSection extends StatelessWidget {
  const _TopicsSection({
    required this.onCategorySelected,
    required this.onCategoryDoubleTapped,
  });

  final ValueChanged<String> onCategorySelected;
  final ValueChanged<String> onCategoryDoubleTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Topics',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Gilroy',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 120.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                  _CategoryCard(
                    title: 'Pregnancy Guide',
                    subtitle: 'Week by week updates',
                    color: const Color(0xFFE8B4CB),
                    onTap: () => onCategorySelected('pregnancy'),
                    onDoubleTap: () => onCategoryDoubleTapped('pregnancy'),
                  ),
                  _CategoryCard(
                    title: 'Birth Control',
                    subtitle: 'Family planning info',
                    color: const Color(0xFFB8D8E0),
                    onTap: () => onCategorySelected('birth_control'),
                    onDoubleTap: () => onCategoryDoubleTapped('birth_control'),
                  ),
                  _CategoryCard(
                    title: 'Nutrition Tips',
                    subtitle: 'Healthy eating guides',
                    color: const Color(0xFFE8D5B7),
                    onTap: () => onCategorySelected('nutrition'),
                    onDoubleTap: () => onCategoryDoubleTapped('nutrition'),
                  ),
                ].divide(const SizedBox(width: 8.0)),
              ),
            ),
          ].divide(const SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
    required this.onDoubleTap,
  });

  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      onDoubleTap: onDoubleTap,
      child: Container(
        width: 180.0,
        height: 120.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: FlutterFlowTheme.of(context).bodyLarge.override(
                      fontFamily: 'Gilroy',
                      letterSpacing: 0.0,
                    ),
              ),
              Text(
                subtitle,
                style: FlutterFlowTheme.of(context).bodySmall.override(
                      fontFamily: 'Gilroy',
                      letterSpacing: 0.0,
                    ),
              ),
            ].divide(const SizedBox(height: 4.0)),
          ),
        ),
      ),
    );
  }
}

class _ArticlesListSection extends StatelessWidget {
  const _ArticlesListSection({required this.articles});

  final List<dynamic> articles;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Insights',
                    style: FlutterFlowTheme.of(context).titleMedium.override(
                          fontFamily: 'Gilroy',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 16.0),
                  primary: false,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: articles.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16.0),
                  itemBuilder: (context, index) {
                    final articleItem = articles[index];
                    return EducationalArticleCardWidget(
                      key: Key('Key528_${index}_of_${articles.length}'),
                      article: EducationalArticleStruct.maybeFromMap(
                          articleItem)!,
                    );
                  },
                ),
              ),
            ),
          ].divide(const SizedBox(height: 16.0)),
        ),
      ),
    );
  }
}

