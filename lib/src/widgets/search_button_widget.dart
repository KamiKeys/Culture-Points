import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//  ---------------------------------------------------------
import 'package:culturepoints/src/models/museos_model.dart';
import 'package:culturepoints/src/providers/museos_provider.dart';
import 'package:culturepoints/src/search/museo_search_delegate.dart';

class SearchButtonWidget extends StatefulWidget {
  @override
  _SearchButtonWidgetState createState() => _SearchButtonWidgetState();
}

class _SearchButtonWidgetState extends State<SearchButtonWidget> {
  List<Museo> museos = [];
  @override
  Widget build(BuildContext context) {
    if (museos.isEmpty) {
      Provider.of<MuseosProvider>(context)
          .getAllMuseos()
          .then((value) => setState(() => museos.addAll(value)));
    }
    return IconButton(
        icon: Icon(Icons.search),
        onPressed: museos.isEmpty
            ? null
            : () {
                showSearch(
                    context: context, delegate: MuseoSearchDelegate(museos));
              });
  }
}
