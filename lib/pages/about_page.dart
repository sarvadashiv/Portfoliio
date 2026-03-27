import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constants.dart';
import '../utils/screen_helper.dart';
import '../widgets/optimized_lottie_asset.dart';
import '../widgets/section_container.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenHelper(
      desktop: _buildUi(desktopMaxWidth, context),
      tablet: _buildUi(tabletMaxWidth, context),
      mobile: _buildUi(ScreenHelper.mobileMaxWidth(context), context),
    );
  }
}

Widget _buildUi(double width, BuildContext context) {
  final isMobile = ScreenHelper.isMobile(context);
  final style = GoogleFonts.oswald(
    color: Colors.white,
    fontSize: isMobile ? 18 : 20,
    height: 1.4,
  );

  final aboutVisual = Center(
    child: OptimizedLottieAsset(
      assetPath: 'assets/animation/coder.json',
      width: isMobile ? 260 : 340,
      height: isMobile ? 260 : 340,
    ),
  );

  final aboutContent = Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'MYSELF',
        style: GoogleFonts.oswald(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.w900,
          height: 1.3,
        ),
      ),
      const SizedBox(height: 16),
      Text(aboutFirst, style: style),
      Text(aboutSecond, style: style),
    ],
  );

  return SectionContainer(
    width: width,
    child: isMobile
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              aboutVisual,
              const SizedBox(height: 24),
              aboutContent,
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: aboutVisual),
              const SizedBox(width: 40),
              Expanded(child: aboutContent),
            ],
          ),
  );
}
