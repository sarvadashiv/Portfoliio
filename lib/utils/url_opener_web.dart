import 'dart:html' as html;

Future<bool> openUrl(String link) async {
  final openedWindow = html.window.open(link, '_blank');
  if (openedWindow == null) {
    html.window.location.assign(link);
  }
  return true;
}
