import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:s_c/features/user_profile/presentation/pages/user_profile_page.dart';
import '../../../features/user_profile/presentation/cubit/user_profile_cubit.dart';
import '../../../features/change_pw/presentation/cubit/change_pw_cubit.dart';
import '../../../features/change_pw/presentation/pages/change_password_page.dart';
import '../../../features/tasks/presentation/pages/task_details_page.dart';
import '../../../features/tasks/presentation/pages/create_new_task_page.dart';
import '../../../features/tasks/presentation/cubit/tasks_cubit.dart';
import '../../../features/register/presentation/cubit/register_cubit.dart';
import '../../../features/register/presentation/pages/register_page.dart';
import '../../../core/enum/app_languages.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/login/presentation/cubit/login_cubit.dart';
import '../../../features/login/presentation/pages/login_page.dart';
import '../../../features/onboarding/pages/onboarding_page.dart';
import '../../../features/splash/presentation/cubit/splash_cubit.dart';
import '../../../features/splash/presentation/pages/splash_page.dart';
import '../../../core/localization/generated/l10n.dart';
import '../../../features/login/domain/entities/login_page_arg.dart';
import '../../../injection_container.dart';
import '../cubit/app_cubit.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.hasFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AppCubit(
              clearRememberedAccount: sl(),
              rememberAccount: sl(),
            ),
          ),
        ],
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            final Locale locale =
                state.appLanguage ?? appSupportedLanguages.first;

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              // theme: appThemes[state],
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: locale,
              builder: EasyLoading.init(),

              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              onGenerateRoute: (setting) {
                final String userId =
                    context.read<AppCubit>().state.authState.user?.uid ?? "";
                if (setting.name == SplashPage.routeName) {
                  return MaterialPageRoute(
                    settings: const RouteSettings(name: SplashPage.routeName),
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => SplashCubit(
                              checkFirstLaunch: sl(),
                              checkRememberedLogin: sl()),
                        ),
                        BlocProvider(
                          create: (context) => LoginCubit(
                            loginWithUsernameAndPw: sl(),
                          ),
                        )
                      ],
                      child: const SplashPage(),
                    ),
                  );
                }
                if (setting.name == OnboardingPage.routeName) {
                  return MaterialPageRoute(
                    settings:
                        const RouteSettings(name: OnboardingPage.routeName),
                    builder: (_) => const OnboardingPage(),
                  );
                }
                if (setting.name == LoginPage.routeName) {
                  final LoginPageArg arg = setting.arguments as LoginPageArg;
                  return MaterialPageRoute<LoginPageArg>(
                    settings: const RouteSettings(name: LoginPage.routeName),
                    builder: (_) => BlocProvider(
                      create: (context) => LoginCubit(
                        loginWithUsernameAndPw: sl(),
                      ),
                      child: LoginPage(
                        arg: arg,
                      ),
                    ),
                  );
                }
                if (setting.name == RegisterPage.routeName) {
                  return MaterialPageRoute(
                    settings: const RouteSettings(name: LoginPage.routeName),
                    builder: (_) => BlocProvider(
                      create: (context) => RegisterCubit(
                          createUserWithEmailAndPassword: sl(),
                          createUserTasksCategory: sl()),
                      child: const RegisterPage(),
                    ),
                  );
                }
                if (setting.name == HomePage.routeName) {
                  return MaterialPageRoute(
                    settings: const RouteSettings(name: HomePage.routeName),
                    builder: (_) => BlocProvider(
                      create: (context) => sl<UserProfileCubit>(),
                      child: const HomePage(),
                    ),
                  );
                }

                if (setting.name == CreateNewTaskPage.routeName) {
                  return MaterialPageRoute(
                    settings:
                        const RouteSettings(name: CreateNewTaskPage.routeName),
                    builder: (_) => BlocProvider(
                      create: (context) => sl<TasksCubit>()
                        ..doInitCreateNewTask(
                          userId: userId,
                        ),
                      child: const CreateNewTaskPage(),
                    ),
                  );
                }
                if (setting.name == TaskDetailsPage.routeName) {
                  final arg = setting.arguments as TaskDetailsArg;
                  return MaterialPageRoute(
                    settings: RouteSettings(name: TaskDetailsPage.routeName),
                    builder: (_) => BlocProvider(
                      create: ((context) => sl<TasksCubit>()
                        ..navToTaskDetails(
                            task: arg.task, listTasks: arg.listTasks)),
                      child: TaskDetailsPage(
                        arg: arg,
                      ),
                    ),
                  );
                }

                if (setting.name == ChangePwPage.routeName) {
                  return MaterialPageRoute(
                    settings: const RouteSettings(name: ChangePwPage.routeName),
                    builder: (_) => BlocProvider(
                      create: (context) => sl<ChangePwCubit>(),
                      child: const ChangePwPage(),
                    ),
                  );
                }
                if (setting.name == UserProfilePage.routeName) {
                  return MaterialPageRoute(
                    settings:
                        const RouteSettings(name: UserProfilePage.routeName),
                    builder: (_) => BlocProvider(
                      create: (context) => sl<UserProfileCubit>()
                        ..doGetUserProfile(userId: userId),
                      child: const UserProfilePage(),
                    ),
                  );
                }

                return null;
              },
              initialRoute: "/",
            );
          },
        ),
      ),
    );
  }
}
