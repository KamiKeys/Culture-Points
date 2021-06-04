import 'package:flutter/material.dart';

//  ---------------------------------------------
import 'package:culturepoints/src/models/museos_model.dart';
import 'package:culturepoints/src/pages/museo_page.dart';

class MuseoSearchDelegate extends SearchDelegate {
  String selection = '';
  final List<Museo> museos;
  List<Museo> suggestions;

  MuseoSearchDelegate(this.museos);

  @override
  List<Widget> buildActions(BuildContext context) {
    //Acciones de la barra de tareas mientras se busca (derecha).
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados a mostrar
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.museum),
            title: Text(suggestions[index].nombre),
            onTap: () {
              selection = suggestions[index].id.toString();
              close(context, null);
              return Navigator.pushNamed(context, MuseoPage.route,
                  arguments: suggestions[index]);
            },
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Crea las sugerencias que aparecen mientras se escribe en la caja de búsqueda
    suggestions = query.isEmpty
        ? museos
        : museos
            .where((element) =>
                element.nombre.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
        itemCount: suggestions?.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.museum),
            title: Text(suggestions[index].nombre),
            onTap: () {
              selection = suggestions[index].id.toString();
              close(context, null);
              return Navigator.pushNamed(context, MuseoPage.route,
                  arguments: suggestions[index]);
            },
          );
        });
  }
}
