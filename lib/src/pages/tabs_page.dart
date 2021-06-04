import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show ChangeNotifierProvider, Provider;

//  -----------------------------------------------------------------
import 'package:culturepoints/src/pages/lista_museos_fav_page.dart';
import 'package:culturepoints/src/pages/lista_museos_page.dart';
import 'package:culturepoints/src/utils/tabs_navigator.dart';
import 'package:culturepoints/src/widgets/search_button_widget.dart';

class TabsPage extends StatefulWidget {
  static String route = 'tabs';

  @override
  _TabsPageState createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => TabsNavigator(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Culture Points'),
              actions: [SearchButtonWidget()],
            ),
            body: _Pages(_tabController),
            bottomNavigationBar: _NavigationBar(_tabController)),
      ),
    );
  }
}

class _Pages extends StatefulWidget {
  final TabController controller;

  _Pages(this.controller);

  @override
  __PagesState createState() => __PagesState();
}

class __PagesState extends State<_Pages> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    final _navigator = Provider.of<TabsNavigator>(context);
    widget.controller
        .addListener(() => _navigator.actualPage = widget.controller.index);
    return TabBarView(
      controller: widget.controller,
      physics: BouncingScrollPhysics(),
      children: [ListaMuseosPage(), ListaMuseosFavPage()],
    );
  }
}

class _NavigationBar extends StatelessWidget {
  final TabController controller;

  _NavigationBar(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).bottomAppBarColor,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 16)],
        ),
        child: TabBar(
          controller: controller,
          tabs: [
            Tab(icon: Icon(Icons.museum), text: 'Museos'),
            Tab(icon: Icon(Icons.favorite), text: 'Favoritos'),
          ],
          labelStyle: Theme.of(context).tabBarTheme.labelStyle,
          unselectedLabelColor: Colors.black26,
          labelColor: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
