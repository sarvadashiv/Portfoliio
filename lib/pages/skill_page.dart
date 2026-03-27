import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../data/skill_list.dart';
import '../utils/constants.dart';
import '../utils/screen_helper.dart';
import '../widgets/section_container.dart';

class SkillPage extends StatelessWidget {
  const SkillPage({super.key});

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
      child: const _SkillContent());
}

class _SkillContent extends StatelessWidget {
  const _SkillContent();

  @override
  Widget build(BuildContext context) {
    final isMobile = ScreenHelper.isMobile(context);

    final skillsVisual = Center(
      child: SizedBox(
        width: isMobile ? 260 : 420,
        height: isMobile ? 260 : 420,
        child: Lottie.asset(
          'assets/animation/skills.json',
          fit: BoxFit.contain,
        ),
      ),
    );

    final skillsContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'SKILLS',
          style: GoogleFonts.oswald(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 28,
              height: 1.3),
        ),
        const SizedBox(height: 12),
        const Text(
          skill,
          style: TextStyle(fontSize: 20, color: captionColor, height: 1.5),
        ),
        const SizedBox(height: 24),
        Column(
          children: skills
              .map(
                (skill) => Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 110,
                        child: Text(
                          skill.skill,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: SizedBox(
                            height: 10,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Container(color: Colors.white24),
                                FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: skill.percentage / 100,
                                  child: Container(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 44,
                        child: Text(
                          '${skill.percentage}%',
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );

    return isMobile
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              skillsVisual,
              const SizedBox(height: 24),
              skillsContent,
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: skillsVisual),
              const SizedBox(width: 40),
              Expanded(flex: 2, child: skillsContent),
            ],
          );
  }
}
