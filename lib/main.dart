import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kenya_yetu_admin/const/AppColors.dart';
import 'package:kenya_yetu_admin/ui/auth_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Kenya Yetu',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: const AuthPage(),
        );
      },
    );
  }
}
