import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:klontong/bloc/auth/login.bloc.dart';
import 'package:klontong/bloc/auth/login.event.dart';
import 'package:klontong/bloc/auth/login.state.dart';
import 'package:klontong/bloc/product/product.bloc.dart';
import 'package:klontong/bloc/product/product.even.dart';
import 'package:klontong/bloc/theme/theme.bloc.dart';
import 'package:klontong/bloc/theme/theme.state.dart';
import 'package:klontong/firebase_options.dart';
import 'package:klontong/repositories/product.repository.dart';
import 'package:klontong/screens/auth/login_page.dart';
import 'package:klontong/screens/product/product_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final productRepository = ProductRepository();

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc()..add(CheckLoginStatus()),
        ),
        BlocProvider<ProductBloc>(
          create: (context) =>
              ProductBloc(productRepository)..add(FetchProducts()),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeState.themeData,
            home: const MainNavigation(),
          );
        },
      ),
    );
  }
}

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccess) {
          return const ProductListPage();
        }
        return LoginPage();
      },
    );
  }
}
