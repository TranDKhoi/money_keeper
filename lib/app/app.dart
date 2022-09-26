import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:money_keeper/app/routes/pages.dart';
import 'package:money_keeper/app/routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
      initialRoute: mainAuthScreenRoute,
      builder: EasyLoading.init(),

      //THEMEEEE
      theme: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light(primary: Colors.green),
        appBarTheme: AppBarTheme(
          elevation: 0,
          foregroundColor: Colors.black,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
            fillColor: Theme.of(context).scaffoldBackgroundColor, filled: true),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black.withOpacity(0.5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Color(0xff818383),
        ),
      ),
    );
  }
}
