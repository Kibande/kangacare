import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:kanga_care/screens/admin_screen.dart';
import 'features/user_authentication/data/datasources/user_authentication_remote_data_source.dart';
import 'features/user_authentication/data/repositories/user_authentication_repository_impl.dart';
import 'features/user_authentication/domain/repositories/user_authentication_repository.dart';
import 'features/user_authentication/presentation/bloc/bloc.dart';
import 'core/network/network_info.dart';
import 'core/providers/credentials_provider.dart';
import 'core/providers/graphql/graphql_config_provider.dart';
import 'features/user_authentication/presentation/pages/forgetPwScreen.dart';
import 'features/user_authentication/presentation/pages/introScreen.dart';
import 'features/user_authentication/presentation/pages/landingScreen.dart';
import 'features/user_authentication/presentation/pages/loginScreen.dart';
import 'features/user_authentication/presentation/pages/newPwScreen.dart';
import 'features/user_authentication/presentation/pages/sentOTPScreen.dart';
import 'features/user_authentication/presentation/pages/signUpScreen.dart';
import 'features/user_authentication/presentation/pages/spashScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'features/user_authentication/domain/usecases/change_password.dart';
import 'features/user_authentication/domain/usecases/change_profile_pic.dart';
import 'features/user_authentication/domain/usecases/change_user_email.dart';
import 'features/user_authentication/domain/usecases/change_user_names.dart';
import 'features/user_authentication/domain/usecases/change_user_phone_number.dart';
import 'features/user_authentication/domain/usecases/delete_account.dart';
import 'features/user_authentication/domain/usecases/invalidate_tokens.dart';
import 'features/user_authentication/domain/usecases/login.dart';
import 'features/user_authentication/domain/usecases/logout.dart';
import 'features/user_authentication/domain/usecases/me.dart';
import 'features/user_authentication/domain/usecases/register_user.dart';
import 'features/user_authentication/domain/usecases/send_email_verification.dart';
import 'features/user_authentication/domain/usecases/send_phone_verification_code.dart';
import 'features/user_authentication/domain/usecases/verify_email_verification_code.dart';
import 'features/user_authentication/domain/usecases/verify_phone_verification_code.dart';

import 'screens/main_screen.dart';

import 'core/app_state.dart';
import 'core/app_themes.dart';
import 'core/util/const.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  // Hive Database
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  // Hive.init(appDocumentDirectory.path);
  await initHiveForFlutter();
  CredentialsProvider();

  SharedPreferences pref = await SharedPreferences.getInstance();
  // final launchStatus = pref.getBool("isFirstlaunch");
  const launchStatus = true;
  runApp(const MyApp(
    launchStatus: launchStatus,
  ));
}

class MyApp extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final launchStatus;

  const MyApp({
    super.key,
    @required this.launchStatus,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppState()),
          ChangeNotifierProvider(create: (_) => GraphQLConfiguration())
        ],
        child: Master(
          launchStatus: launchStatus,
        ));
  }
}

class Master extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final launchStatus;
  const Master({
    super.key,
    @required this.launchStatus,
  });

  @override
  State<Master> createState() => _MasterState();
}

class _MasterState extends State<Master> {
  @override
  Widget build(BuildContext context) {
    final graphQLConfigProvider =
        Provider.of<GraphQLConfiguration>(context, listen: true);

    return GraphQLProvider(
      client: graphQLConfigProvider.graphqlClient(),
      child: CacheProvider(
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<UserAutheniticationRepository>(
              create: (_) => UserAuthenticationRepositoryImpl(
                remoteDataSource: UserAuthenticationRemoteDataSourceImpl(
                  graphqlClient: graphQLConfigProvider.clientToQuery(),
                ),
                networkInfo: NetworkInfoImpl(connectionChecker: String),
              ),
            )
          ],
          child: Slave(
            launchStatus: widget.launchStatus,
          ),
        ),
      ),
    );
  }
}

class Slave extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final launchStatus;

  const Slave({
    super.key,
    @required this.launchStatus,
  });

  @override
  State<Slave> createState() => _SlaveState();
}

class _SlaveState extends State<Slave> {
  @override
  Widget build(BuildContext context) {
    final userAutheniticationRepository =
        RepositoryProvider.of<UserAutheniticationRepository>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<UserAuthenticationBloc>(
          create: (_) => UserAuthenticationBloc(
            changePassword:
                ChangePassword(repository: userAutheniticationRepository),
            changeProfilePic:
                ChangeProfilePic(repository: userAutheniticationRepository),
            changeUserEmail:
                ChangeUserEmail(repository: userAutheniticationRepository),
            changeUserNames:
                ChangeUserNames(repository: userAutheniticationRepository),
            changeUserPhoneNumber: ChangeUserPhoneNumber(
                repository: userAutheniticationRepository),
            deleteAccount:
                DeleteAccount(repository: userAutheniticationRepository),
            invalidateTokens:
                InvalidateTokens(repository: userAutheniticationRepository),
            login: Login(repository: userAutheniticationRepository),
            logout: Logout(repository: userAutheniticationRepository),
            me: Me(repository: userAutheniticationRepository),
            registerUser:
                RegisterUser(repository: userAutheniticationRepository),
            sendEmailVerificationCode: SendEmailVerificationCode(
                repository: userAutheniticationRepository),
            sendPhoneVerificationCode: SendPhoneVerificationCode(
                repository: userAutheniticationRepository),
            verifyEmailVerificationCode: VerifyEmailVerificationCode(
                repository: userAutheniticationRepository),
            verifyPhoneVerificationCode: VerifyPhoneVerificationCode(
                repository: userAutheniticationRepository),
          ),
        ),
      ],
      child: MaterialAppWidget(
        launchStatus: widget.launchStatus,
      ),
    );
  }
}

class MaterialAppWidget extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final launchStatus;
  const MaterialAppWidget({super.key, @required this.launchStatus});

  @override
  State<MaterialAppWidget> createState() => _MaterialAppWidgetState();
}

class _MaterialAppWidgetState extends State<MaterialAppWidget> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: appState.getCurrentTheme.colorScheme.surface,
      statusBarIconBrightness:
          appState.currentTheme == CustomAppThemes.lightTheme
              ? Brightness.dark
              : Brightness.light,
      statusBarBrightness: appState.currentTheme == CustomAppThemes.lightTheme
          ? Brightness.dark
          : Brightness.light,
      systemNavigationBarColor: appState.getCurrentTheme.colorScheme.surface,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness:
          appState.currentTheme == CustomAppThemes.lightTheme
              ? Brightness.dark
              : Brightness.light,
    ));

    String deterimineIntialRoute() {
      if (widget.launchStatus ?? true) {
        return SplashScreen.routeName;
      } else {
        return MainScreen.routeName;
      }
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: appState.getCurrentTheme,
      darkTheme: CustomAppThemes.darkTheme,
      initialRoute: deterimineIntialRoute(),
      routes: {
        MainScreen.routeName: (ctx) => MainScreen(),
        SplashScreen.routeName: (ctx) => const SplashScreen(),
        LandingScreen.routeName: (ctx) => const LandingScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignUpScreen.routeName: (ctx) => SignUpScreen(),
        ForgetPwScreen.routeName: (ctx) => ForgetPwScreen(),
        SendOTPScreen.routeName: (ctx) => SendOTPScreen(),
        NewPwScreen.routeName: (ctx) => NewPwScreen(),
        IntroScreen.routeName: (ctx) => IntroScreen(),
        AdminScreen.routeName: (ctx) => AdminScreen(),
      },
    );
  }
}
