import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // En Android usa google-services.json automaticamente
  // En Web usa las variables de entorno
  try {
    await Firebase.initializeApp(
      options: Env.firebaseApiKey.isEmpty ? null : FirebaseOptions(
        apiKey:            Env.firebaseApiKey,
        authDomain:        Env.firebaseAuthDomain,
        projectId:         Env.firebaseProjectId,
        storageBucket:     Env.firebaseStorageBucket,
        messagingSenderId: Env.firebaseSenderId,
        appId:             Env.firebaseAppId,
      ),
    );
  } catch (e) {
    await Firebase.initializeApp();
  }

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
