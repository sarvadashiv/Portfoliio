import 'package:flutter/material.dart';

import '../utils/screen_helper.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.width,
    required this.child,
    this.showDivider = true,
  });

  final double width;
  final Widget child;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final isMobile = ScreenHelper.isMobile(context);
    final sectionGap = isMobile ? 45.0 : 88.0;

    return Padding(
      padding: EdgeInsets.only(
        left: isMobile ? 20 : 32,
        right: isMobile ? 20 : 32,
        top: sectionGap,
      ),
      child: Center(
        child: SizedBox(
          width: width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              child,
              if (showDivider) ...[
                SizedBox(height: sectionGap),
                Container(
                  height: 1,
                  color: Colors.white24,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
