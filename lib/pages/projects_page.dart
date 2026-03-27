import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shivansh_verma4/utils/constants.dart';

import '../data/projects.dart';
import '../models/project.dart';
import '../utils/screen_helper.dart';
import '../utils/utils.dart';
import '../widgets/section_container.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenHelper(
      desktop: _buildUi(desktopMaxWidth, context),
      tablet: _buildUi(tabletMaxWidth, context),
      mobile: _buildUi(ScreenHelper.mobileMaxWidth(context), context),
    );
  }

  Widget _buildUi(double width, BuildContext context) => SectionContainer(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Projects',
              style: GoogleFonts.oswald(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  height: 1.3),
            ),
            const SizedBox(height: 5),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: const Text(
                'These are my best projects till date, made in love, stay tuned for new ones.',
                style:
                    TextStyle(color: Colors.white, fontSize: 20, height: 1.5),
              ),
            ),
            const SizedBox(height: 40),
            LayoutBuilder(builder: (context, constraints) {
              const gridSpacing = 32.0;
              final useTwoColumns = constraints.maxWidth >= 600;
              final cardWidth = useTwoColumns
                  ? ((constraints.maxWidth - gridSpacing) / 2)
                      .clamp(260.0, 420.0)
                      .toDouble()
                  : constraints.maxWidth;

              return Wrap(
                alignment: WrapAlignment.center,
                spacing: gridSpacing,
                runSpacing: gridSpacing,
                children: projects
                    .map((project) => SizedBox(
                          width: cardWidth,
                          child: _ProjectCard(
                            project: project,
                            useTwoColumns: useTwoColumns,
                          ),
                        ))
                    .toList(),
              );
            })
          ],
        ),
      );
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.useTwoColumns,
  });

  final Project project;
  final bool useTwoColumns;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RepaintBoundary(
          child: Image.asset(project.image),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          project.description,
          maxLines: useTwoColumns ? 4 : null,
          overflow: useTwoColumns ? TextOverflow.ellipsis : null,
          style: const TextStyle(
            color: captionColor,
            fontSize: 20,
            height: 1.5,
          ),
        ),
        IconButton(
          onPressed: () => Utils.launchURL(project.gitLink),
          icon: const FaIcon(FontAwesomeIcons.github),
          color: Colors.white70,
          iconSize: 24,
        )
      ],
    );
  }
}
