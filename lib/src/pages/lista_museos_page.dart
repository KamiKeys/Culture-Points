import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//  --------------------------------------------------------------
import 'package:culturepoints/src/models/museos_model.dart';
import 'package:culturepoints/src/pages/museo_page.dart';
import 'package:culturepoints/src/providers/museos_provider.dart';

class ListaMuseosPage extends StatefulWidget {
  static final String route = "lista_museos";

  ListaMuseosPage({Key key}) : super(key: key);

  @override
  _ListaMuseosPageState createState() => _ListaMuseosPageState();
}

class _ListaMuseosPageState extends State<ListaMuseosPage> {
  //final museosProvider = new MuseosProvider();
  final List<Museo> museos = [];
  ScrollController _scrollController = new ScrollController();
  bool _isLoading = false;
  SharedPreferences prefs;
  List<String> favs;
  MuseosProvider museosProvider;

  @override
  void initState() {
    super.initState();
  }

  void init(BuildContext context) async {
    museosProvider = Provider.of<MuseosProvider>(context);
    prefs = await SharedPreferences.getInstance();
    favs = prefs.getStringList("favs") ?? [];
    getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
                  _scrollController.position.maxScrollExtent &&
              museos.length < museosProvider.max ??
          10) {
        fetchData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (museosProvider == null) {
      init(context);
    }
    return Scaffold(
        body: museos.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Stack(
                children: <Widget>[
                  _crearLista(),
                  _crearLoading(),
                ],
              ));
  }

  Widget _crearLista() {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: museos.length,
        itemBuilder: (BuildContext context, int index) {
          final museo = museos[index];
          return ListTile(
            leading: Icon(Icons.museum),
            trailing: IconButton(
                onPressed: () {
                  setState(() {
                    if (favs.firstWhere(
                          (element) => int.parse(element) == museos[index].id,
                          orElse: () => null,
                        ) !=
                        null) {
                      favs.remove(museos[index].id.toString());
                      prefs.setStringList("favs", favs);
                    } else {
                      favs.add(museos[index].id.toString());
                      prefs.setStringList("favs", favs);
                    }
                  });
                },
                icon: Icon(Icons.favorite,
                    color: favs.firstWhere(
                              (element) =>
                                  int.parse(element) == museos[index].id,
                              orElse: () => null,
                            ) !=
                            null
                        ? Colors.red
                        : Colors.black26)),
            title: Text(museo.nombre),
            onTap: () => Navigator.pushNamed(context, MuseoPage.route,
                arguments: museos[index]),
            subtitle: Text(
              museo.direccion,
              style: Theme.of(context).textTheme.caption,
            ),
          );
        },
      ),
    );
  }

  Widget _crearLoading() {
    if (_isLoading) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator()],
          ),
          SizedBox(height: 15.0)
        ],
      );
    } else {
      return Container();
    }
  }

  void getData() {
    museosProvider.getMuseos().then((value) => setState(() {
          museos.clear();
          museos.addAll(value);
        }));
  }

  void fetchData() {
    setState(() {
      _isLoading = true;
    });
    museosProvider.getMuseos().then((value) {
      setState(() {
        museos.clear();
        museos.addAll(value);
        _isLoading = false;
      });
      _scrollController?.animateTo(_scrollController.position.pixels + 60,
          curve: Curves.fastOutSlowIn, duration: Duration(milliseconds: 500));
    });
  }

  Future<void> _refresh() async {
    setState(() {
      museos.clear();
      museosProvider.museos.clear();
    });
    getData();
  }
}
