import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey:            dotenv.env['FIREBASE_API_KEY']!,
      authDomain:        dotenv.env['FIREBASE_AUTH_DOMAIN']!,
      projectId:         dotenv.env['FIREBASE_PROJECT_ID']!,
      storageBucket:     dotenv.env['FIREBASE_STORAGE_BUCKET']!,
      messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
      appId:             dotenv.env['FIREBASE_APP_ID']!,
    ),
  );
  runApp(const ProviderScope(child: ReflectaApp()));
}

class ReflectaApp extends ConsumerWidget {
  const ReflectaApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Reflecta Daily',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
