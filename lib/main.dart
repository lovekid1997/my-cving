import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_cving/app/app.dart';
import 'package:my_cving/app/config/config.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupFont();
  setPathUrlStrategy();
  runApp(const ProviderScope(child: MyApp()));
}
