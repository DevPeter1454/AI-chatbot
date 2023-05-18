import 'package:ask_ai/open_ai.dart';
import 'package:dart_openai/openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ask_ai/app/app.bottomsheets.dart';
import 'package:ask_ai/app/app.dialogs.dart';
import 'package:ask_ai/app/app.locator.dart';
import 'package:ask_ai/app/app.router.dart';
import 'package:ask_ai/ui/common/app_colors.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:sizer/sizer.dart';

void main() {
  setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  WidgetsFlutterBinding.ensureInitialized();
  OpenAI.apiKey = yourAPIKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: Theme.of(context).copyWith(
            primaryColor: kcBackgroundColor,
            focusColor: kcPrimaryColor,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.black,
                ),
            useMaterial3: true,
          ),
          initialRoute: Routes.startupView,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [
            StackedService.routeObserver,
          ],
        );
      },
    );
  }
}
