import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:task_27_03/Provider/chat_provider.dart';
import 'package:task_27_03/Routesetting/route_setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:task_27_03/pages/storePages/chatPage/store_chat.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await initLocalStorage();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
        designSize: Size(screenwidth, screenheight),
        child: ChangeNotifierProvider(
          create: (context) => ChatProvider(),
          child: MaterialApp(
            supportedLocales: const [Locale('en'), Locale('hi')],
            locale: const Locale('hi'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const StoreChat(),
            
            // initialRoute: '/',
            onGenerateRoute: RouteManager.generateRoute,
          ),
        ));
  }
}
