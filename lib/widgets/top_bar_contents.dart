import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shivansh_verma4/utils/constants.dart';
import '../utils/globals.dart';
import '../utils/screen_helper.dart';

class TopBarContents extends StatelessWidget {
  const TopBarContents(
      {super.key, required this.opacity, required this.onSectionSelected});
  final double opacity;
  final Future<void> Function(int index) onSectionSelected;
  @override
  Widget build(BuildContext context) {
    final desktopHeader = PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: DesktopTabBar(
          opacity: opacity,
          onSectionSelected: onSectionSelected,
        ));
    return ScreenHelper(
      desktop: desktopHeader,
      tablet: desktopHeader,
      mobile: buildMobileHeader(),
    );
  }
}

class DesktopTabBar extends StatelessWidget {
  const DesktopTabBar(
      {super.key, required this.opacity, required this.onSectionSelected});
  final double opacity;
  final Future<void> Function(int index) onSectionSelected;
  InkWell menuItem({required int toPage, required String title}) {
    return InkWell(
      onTap: () => onSectionSelected(toPage),
      child: Text(
        title,
        style: const TextStyle(
            color: primaryColor, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withValues(alpha: opacity),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 24,
            ),
            menuItem(toPage: 0, title: 'Home'),
            const SizedBox(
              width: 24,
            ),
            menuItem(toPage: 1, title: 'About'),
            const SizedBox(
              width: 24,
            ),
            menuItem(toPage: 2, title: 'My Projects'),
            const SizedBox(
              width: 24,
            ),
            menuItem(toPage: 3, title: 'Education'),
            const SizedBox(
              width: 24,
            ),
            menuItem(toPage: 4, title: 'My Skills'),
            const SizedBox(
              width: 24,
            ),
            menuItem(toPage: 5, title: 'Contact me'),
          ],
        ),
      ),
    );
  }
}

Widget buildMobileHeader() => SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderLogo(),
          GestureDetector(
            onTap: () => Globals.scaffoldKey.currentState!.openEndDrawer(),
            child: const Icon(
              Icons.menu,
              color: Colors.white,
              size: 28,
            ),
          )
        ],
      ),
    ));

class HeaderLogo extends StatelessWidget {
  HeaderLogo({super.key});
  final TextStyle style = GoogleFonts.oswald(
      color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 10),
      child: RichText(
          text: TextSpan(children: [
        TextSpan(text: name.characters.first, style: style),
        TextSpan(text: '.', style: style)
      ])),
    );
  }
}
