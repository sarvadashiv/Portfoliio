import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shivansh_verma4/utils/constants.dart';

import '../utils/screen_helper.dart';
import '../utils/utils.dart';
import '../widgets/section_container.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final List<MaterialColor> colorizeColors = [
    Colors.brown,
    Colors.purple,
    Colors.amber,
    Colors.cyan,
  ];
  final List<String> roleTexts = const [
    'Passionate',
    'HardWorking',
    'a Software Dev',
  ];

  double _measureMaxTextWidth(TextStyle style) {
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );

    double maxWidth = 0;
    for (final roleText in roleTexts) {
      textPainter.text = TextSpan(text: roleText, style: style);
      textPainter.layout();
      if (textPainter.width > maxWidth) {
        maxWidth = textPainter.width;
      }
    }
    return maxWidth;
  }

  @override
  Widget build(BuildContext context) => ScreenHelper(
      desktop: _buildUi(desktopMaxWidth),
      tablet: _buildUi(tabletMaxWidth),
      mobile: _buildUi(ScreenHelper.mobileMaxWidth(context)));
  Widget _buildUi(double width) {
    final isMobile = ScreenHelper.isMobile(context);
    final titleSize = isMobile ? 36.0 : 50.0;
    final animatedTextSize = isMobile ? 28.0 : 40.0;
    final animatedTextStyle = TextStyle(
      fontFamily: 'Horizon',
      fontSize: animatedTextSize,
      color: Colors.white,
    );
    final roleWidth = _measureMaxTextWidth(animatedTextStyle) + 4;
    final descriptionStyle = TextStyle(
      fontSize: isMobile ? 18 : 20,
      fontWeight: FontWeight.w400,
      color: Colors.white70,
      height: 1.5,
    );

    final introContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        const Text(
          helloTag,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w100,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          name,
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: titleSize,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) => Align(
            alignment: isMobile ? Alignment.center : Alignment.centerLeft,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'I\'m',
                    style: animatedTextStyle,
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    width: roleWidth,
                    height: animatedTextSize * 1.8,
                    child: DefaultTextStyle(
                      textAlign: TextAlign.left,
                      style: animatedTextStyle,
                      child: AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: roleTexts
                            .map(
                              (roleText) => RotateAnimatedText(
                                roleText,
                                alignment: Alignment.centerLeft,
                                transitionHeight: animatedTextSize * 1.6,
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 0),
          child: Text(
            miniDescription,
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: descriptionStyle,
          ),
        ),
        const SizedBox(height: 30),
        Align(
          alignment: isMobile ? Alignment.center : Alignment.centerLeft,
          child: ElevatedButton(
            onPressed: () => Utils.launchURL(resumeUrl),
            style: ElevatedButton.styleFrom(
              side: const BorderSide(width: 3, color: Colors.white),
              backgroundColor: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            ),
            child: IgnorePointer(
              child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  ColorizeAnimatedText(
                    "Resume",
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: colorizeColors,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );

    final heroVisual = Center(
      child: SizedBox(
        width: isMobile ? 260 : 360,
        height: isMobile ? 260 : 360,
        child: Lottie.asset(
          'assets/animation/yoga.json',
          fit: BoxFit.contain,
        ),
      ),
    );

    return SectionContainer(
      width: width,
      child: isMobile
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                heroVisual,
                const SizedBox(height: 24),
                introContent,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: introContent),
                const SizedBox(width: 30),
                Expanded(child: heroVisual),
              ],
            ),
    );
  }
}
