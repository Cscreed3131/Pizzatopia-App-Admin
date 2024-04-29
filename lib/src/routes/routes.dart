import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/authentication_bloc/authentication_bloc.dart';

final _navKey = GlobalKey<NavigatorState>();
final _shellNavigationKey = GlobalKey<NavigatorState>();

GoRouter router(AuthenticationBloc authBloc) {
  return GoRouter(
      navigatorKey: _navKey,
      initialLocation: '/',
      redirect: (context, state) {
        if (authBloc.state.status == AuthenticationStatus.unknown) {
          return '/';
        }
      },
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigationKey,
          builder: (context, state, child) {
            if (state.fullPath == '/login' || state.fullPath == '/') {
              return child;
            } else {
              return BaseScreen(child);
            }
          },
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) =>
                  BlocProvider<AuthenticationBloc>.value(
                value: BlocProvider.of<AuthenticationBloc>(context),
                child: SplashScreen(),
              ),
            ),
            GoRoute(
              path: '/login',
              builder: (context, state) =>
                  BlocProvider<AuthenticationBloc>.value(
                value: BlocProvider.of<AuthenticationBloc>(context),
                child: LoginScreen(),
              ),
            ),
            GoRoute(
              path: '/home',
              builder: (context, state) =>
                  BlocProvider<AuthenticationBloc>.value(
                value: BlocProvider.of<AuthenticationBloc>(context),
                child: HomeScreen(),
              ),
            ),
          ],
        )
      ]);
}
