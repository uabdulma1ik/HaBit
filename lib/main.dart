import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:habit/data/note_model.dart';
import 'package:habit/logic/OCR/ocr_bloc.dart';
import 'package:habit/logic/note/note_bloc.dart';
import 'package:habit/logic/auth/auth_bloc.dart';
import 'package:habit/logic/my_profile/my_profile_bloc.dart';
import 'package:habit/logic/my_profile/my_profile_event.dart';
import 'package:habit/logic/navigation/navigation_bar_bloc.dart';
import 'package:habit/logic/onBoarding/onboarding_bloc.dart';
import 'package:habit/screens/OCR/ocr_screen.dart';
import 'package:habit/screens/about/about_screen.dart';
import 'package:habit/screens/note/note_screen.dart';
import 'package:habit/screens/auth/Log_in/log_in_screen.dart';
import 'package:habit/screens/auth/create_account/create_account_screen.dart';
import 'package:habit/screens/auth/forgot_password/forgot_password_screen.dart';
import 'package:habit/screens/splash/splash_screen.dart';
import 'package:habit/screens/wrapper/wrapper.dart';
import 'package:habit/screens/help/help_screen.dart';
import 'package:habit/screens/nav_bar/navigation.dart';
import 'package:habit/screens/myProfile/myProfile_screen.dart';
import 'package:habit/screens/onBoarding/onBoarding_screen.dart';
import 'package:habit/screens/settings/settings_screen.dart';
import 'package:habit/services/auth_service/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc(authService: AuthService())),
        BlocProvider(create: (_) => NoteBloc()..add(LoadNotesEvent())),
        BlocProvider(create: (_) => OnboardingBloc()),
        BlocProvider(create: (_) => NavigationBloc()),
        BlocProvider(create: (_) => OcrBloc()),
        BlocProvider(create: (_) => MyProfileBloc()..add(LoadProfile())),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
        GoRoute(
          path: '/onBoarding',
          builder: (context, state) => const OnboardingScreen(),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const AboutScreen(),
        ),
        GoRoute(path: '/home', builder: (context, state) => Navigation()),
        GoRoute(path: '/help', builder: (context, state) => const HelpScreen()),
        GoRoute(
          path: '/myProfile',
          builder: (context, state) => const MyprofileScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(path: '/ocr', builder: (context, state) => const OcrScreen()),
        GoRoute(
          path: '/logIn',
          builder: (context, state) => const LogInScreen(),
        ),
        GoRoute(
          path: '/createAccount',
          builder: (context, state) => const CreateAccountScreen(),
        ),
        GoRoute(
          path: '/forgot',
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: '/addNote',
          builder: (context, state) => AddNoteScreen(
            note: Note(
              id: '',
              title: '',
              note: '',
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
              color: 0xFFFFFFFF,
            ),
          ),
        ),
        GoRoute(path: '/wrapper', builder: (context, state) => const Wrapper()),
      ],
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}