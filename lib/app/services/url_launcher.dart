import 'package:my_cving/app/services/logger.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  final Uri base;

  static final _instance = UrlLauncher._internal(Uri.base);

  UrlLauncher._internal(this.base);

  factory UrlLauncher() {
    return _instance;
  }

  Future<void> launchUrlNewTab(String url) async {
    try {
      Uri.base;
      final uri = Uri.parse(url);
      await launchUrl(uri);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> launchMail(String emailAddress) async {
    try {
      final Uri emailLaunchUri = Uri(
        scheme: 'mailto',
        path: emailAddress,
        query: <String, String>{
          'subject': 'Example Subject & Symbols are allowed!',
        }
            .entries
            .map((e) =>
                '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
            .join('&'),
      );

      await launchUrl(emailLaunchUri);
    } catch (e) {
      logger.e(e);
    }
  }
}
