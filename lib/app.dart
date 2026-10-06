import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/constants/prefs_keys.dart';
import 'core/di/app_container.dart';
import 'core/localization/locale_cubit.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/domain/usecases/register_user.dart';
import 'features/auth/domain/usecases/restore_session.dart';
import 'features/auth/domain/usecases/sign_in.dart';
import 'features/auth/domain/usecases/sign_out.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/places/domain/usecases/add_place.dart';
import 'features/places/domain/usecases/get_places.dart';
import 'features/places/presentation/bloc/places_bloc.dart';
import 'l10n/generated/app_localizations.dart';

class HelpIApp extends StatelessWidget {
  const HelpIApp({super.key, required this.container});

  final AppContainer container;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocaleCubit>(
          create: (_) => LocaleCubit(
            Locale(container.prefs.getString(PrefsKeys.locale) ?? 'en'),
          ),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(
            signIn: SignIn(container.authRepository),
            registerUser: RegisterUser(container.authRepository),
            restoreSession: RestoreSession(container.authRepository),
            signOut: SignOut(container.authRepository),
          )..add(const AuthSessionRestored()),
        ),
        BlocProvider<PlacesBloc>(
          create: (_) => PlacesBloc(
            getPlaces: GetPlaces(container.placesRepository),
            addPlace: AddPlace(container.placesRepository),
          )..add(const PlacesLoadRequested()),
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) => MaterialApp(
          title: 'HelpI',
          debugShowCheckedModeBanner: false,
          locale: locale,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: buildAppTheme(),
          initialRoute: AppRoutes.splash,
          onGenerateRoute: AppRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
