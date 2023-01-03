import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cving/app/app.dart';
import 'package:my_cving/app/config/config.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHive();
  setupFont();
  setPathUrlStrategy();
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://cad0a4d2614645b399938187a00f8616@o4504373196423168.ingest.sentry.io/4504373197209600';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 0.0;
    },
    appRunner: () => runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}
