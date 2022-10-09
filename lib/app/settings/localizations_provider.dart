import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localizationsProvider = StateProvider<Locale>((_) => const Locale('vi'));
