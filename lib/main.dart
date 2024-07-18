import 'package:animate_demo01/menu_dashb_widget.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
   await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(450, 700),
    minimumSize: Size(450, 800),
    backgroundColor: Colors.transparent,
    titleBarStyle: TitleBarStyle.normal,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Menu Dashboard",
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home:MenuDashBoard(),
    );
  }
}