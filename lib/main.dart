import 'package:dynamic_path_url_strategy/dynamic_path_url_strategy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:read_ease_app/core/constants/app_colors.dart';
import 'package:read_ease_app/features/books/data/models/app_user/app_user.dart';
import 'package:read_ease_app/features/books/data/models/book/book.dart';
import 'package:read_ease_app/features/books/data/src/local_source/local_data_source.dart';
import 'config/router/router_provider.dart';
import 'core/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.secondaryColor,
    ),
  );

  setPathUrlStrategy();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Hive.registerAdapter(AppUserImplAdapter());
  Hive.registerAdapter(BookImplAdapter());
  if (!Hive.isBoxOpen(LocalDataSource.boxName)) {
    await Hive.openBox<AppUser>(LocalDataSource.boxName);
  }

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.secondaryColor,
              ),
              scaffoldBackgroundColor: AppColors.secondaryColor,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryColor,
              ),
              fontFamily: 'Inter',
              useMaterial3: true,
            ),
            routerConfig: router,
          );
        });
  }
}
