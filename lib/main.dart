import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

//  ------------------------------------
import 'package:culturepoints/src/routes/routes.dart';
import 'package:culturepoints/src/pages/tabs_page.dart';
import 'package:culturepoints/src/providers/museos_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Brightness _brightness = SchedulerBinding.instance.window.platformBrightness;

  @override
  void initState() {
    super.initState();
    final window = WidgetsBinding.instance.window;
    window.onPlatformBrightnessChanged =
        () => setState(() => _brightness = window.platformBrightness);
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => MuseosProvider(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.red, brightness: _brightness),
        title: 'Culture Points',
        debugShowCheckedModeBanner: false,
        initialRoute: TabsPage.route,
        routes: getApplicationRoutes(),
      ),
    );
  }
}
