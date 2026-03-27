import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shivansh_verma4/utils/constants.dart';
import '../data/educations.dart';

import '../utils/screen_helper.dart';
import '../widgets/section_container.dart';

class EducationPage extends StatelessWidget {
  const EducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenHelper(
      mobile: _buildUi(ScreenHelper.mobileMaxWidth(context), context),
      tablet: _buildUi(tabletMaxWidth, context),
      desktop: _buildUi(desktopMaxWidth, context),
    );
  }

  Widget _buildUi(double width, BuildContext context) => SectionContainer(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "EDUCATION",
              style: GoogleFonts.oswald(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  height: 1.3),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              education,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                height: 1.5,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            LayoutBuilder(builder: (context, constraints) {
              const gridSpacing = 32.0;
              final columns = constraints.maxWidth >= 900
                  ? 3
                  : constraints.maxWidth >= 560
                      ? 2
                      : 1;
              final cardWidth = columns == 1
                  ? constraints.maxWidth
                  : ((constraints.maxWidth - (gridSpacing * (columns - 1))) /
                          columns)
                      .clamp(220.0, 360.0)
                      .toDouble();

              return Wrap(
                alignment: WrapAlignment.start,
                spacing: gridSpacing,
                runSpacing: gridSpacing,
                children: educations
                    .map((education) => SizedBox(
                          width: cardWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                education.period,
                                style: GoogleFonts.oswald(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                education.description,
                                maxLines: columns > 1 ? 4 : null,
                                overflow: columns > 1
                                    ? TextOverflow.ellipsis
                                    : null,
                                style: const TextStyle(
                                  color: captionColor,
                                  fontSize: 20,
                                  height: 1.5,
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList(),
              );
            })
          ],
        ),
      );
}
