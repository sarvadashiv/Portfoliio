import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shivansh_verma4/pages/projects_page.dart';
import 'package:shivansh_verma4/pages/skill_page.dart';
import 'package:shivansh_verma4/pages/welcome_page.dart';
import 'package:shivansh_verma4/widgets/drawer_widget.dart';
import '../utils/globals.dart';
import '../widgets/top_bar_contents.dart';
import 'about_page.dart';
import 'education_page.dart';
import 'footer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final List<Widget> pages = const [
    WelcomePage(),
    AboutPage(),
    ProjectsPage(),
    EducationPage(),
    SkillPage(),
    FooterPage()
  ];
  late final List<GlobalKey> sectionKeys =
      List.generate(pages.length, (_) => GlobalKey());

  Future<void> _scrollToSection(int index) async {
    if (index < 0 || index >= sectionKeys.length) {
      return;
    }

    final targetContext = sectionKeys[index].currentContext;
    if (targetContext == null) {
      return;
    }

    final renderObject = targetContext.findRenderObject();
    if (renderObject == null) {
      return;
    }

    final viewport = RenderAbstractViewport.of(renderObject);
    final position = _scrollController.position;
    if (viewport == null) {
      return;
    }

    final targetOffset =
        viewport.getOffsetToReveal(renderObject, 0).offset - 24;
    final clampedOffset = targetOffset.clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );

    await _scrollController.animateTo(
      clampedOffset.toDouble(),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Globals.scaffoldKey,
      appBar: PreferredSize(
        preferredSize: const Size(100, 100),
        child: TopBarContents(
          opacity: 0,
          onSectionSelected: _scrollToSection,
        ),
      ),
      endDrawer: DrawerWidget(onSectionSelected: _scrollToSection),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/back.jpeg'), fit: BoxFit.cover)),
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              for (var index = 0; index < pages.length; index++)
                KeyedSubtree(
                  key: sectionKeys[index],
                  child: pages[index],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
