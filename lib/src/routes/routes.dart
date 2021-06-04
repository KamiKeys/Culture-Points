import 'package:culturepoints/src/pages/tabs_page.dart';
import 'package:flutter/material.dart';

//  ----------------------------------------
import 'package:culturepoints/src/pages/lista_museos_page.dart';
import 'package:culturepoints/src/pages/museo_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    MuseoPage.route: (BuildContext context) => MuseoPage(),
    TabsPage.route: (BuildContext context) => TabsPage(),
  };
}
