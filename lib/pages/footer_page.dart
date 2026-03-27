import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/footer_items.dart';
import '../models/footer_item.dart';
import '../utils/constants.dart';
import '../utils/screen_helper.dart';

class FooterPage extends StatelessWidget {
  const FooterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenHelper(
      mobile: _buildUi(ScreenHelper.mobileMaxWidth(context), context),
      tablet: _buildUi(tabletMaxWidth, context),
      desktop: _buildUi(desktopMaxWidth, context),
    );
  }

  Widget _buildUi(double width, BuildContext context) => Center(
        child: SizedBox(
            width: width,
            child: LayoutBuilder(builder: (context, constraints) {
              const gridSpacing = 32.0;
              final columns = constraints.maxWidth >= 920
                  ? 4
                  : constraints.maxWidth >= 560
                      ? 2
                      : 1;
              final itemWidth = columns == 4
                  ? ((constraints.maxWidth - (gridSpacing * 3)) / 4)
                      .clamp(180.0, 220.0)
                      .toDouble()
                  : columns == 2
                      ? ((constraints.maxWidth - gridSpacing) / 2)
                          .clamp(220.0, 320.0)
                          .toDouble()
                      : constraints.maxWidth;
              final gridWidth =
                  (itemWidth * columns) + (gridSpacing * (columns - 1));

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Center(
                      child: SizedBox(
                        width: gridWidth,
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          spacing: gridSpacing,
                          runSpacing: gridSpacing,
                          children: footerItems
                              .map((footerItem) => SizedBox(
                                    height: 120,
                                    width: itemWidth,
                                    child: _FooterItemCard(
                                      footerItem: footerItem,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Copyright (c) 2024 $name. All rights reserved',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: captionColor),
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: const MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Text(
                                  "Privacy Policy",
                                  style: TextStyle(color: captionColor),
                                ),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: const Text(
                                '|',
                                style: TextStyle(color: captionColor),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: Text(
                                  "Terms & condition",
                                  style: TextStyle(color: captionColor),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              );
            })),
      );
}

class _FooterItemCard extends StatelessWidget {
  const _FooterItemCard({required this.footerItem});

  final FooterItem footerItem;

  @override
  Widget build(BuildContext context) {
    final details = <String>[
      footerItem.text1,
      if (footerItem.text2 != null && footerItem.text2!.trim().isNotEmpty)
        footerItem.text2!,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(footerItem.iconPath, width: 25),
            const SizedBox(width: 15),
            Text(
              footerItem.title,
              style: GoogleFonts.oswald(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            )
          ],
        ),
        const SizedBox(height: 15),
        Text(
          details.join('\n'),
          style: const TextStyle(
            color: captionColor,
            height: 1.8,
          ),
        ),
      ],
    );
  }
}
