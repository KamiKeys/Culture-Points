import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

//  --------------------------------------------------------------
import 'package:culturepoints/src/models/museos_model.dart';

class MuseoPage extends StatefulWidget {
  static String route = "museo";

  @override
  _MuseoPageState createState() => _MuseoPageState();
}

class _MuseoPageState extends State<MuseoPage> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final Museo museo = ModalRoute.of(context).settings.arguments;
    final CameraPosition ubicacionMuseo = CameraPosition(
      target: LatLng(museo.latitud, museo.longitud),
      zoom: 18,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(museo.nombre),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 250,
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: ubicacionMuseo,
                onMapCreated: (GoogleMapController controller) =>
                    _controller.complete(controller),
                markers: <Marker>{
                  Marker(
                    markerId: MarkerId(museo.id.toString()),
                    position: ubicacionMuseo.target,
                  )
                },
              ),
            ),
            museo.nombre?.isNotEmpty ?? false
                ? ListTile(
                    leading: Icon(Icons.museum),
                    title: Text(museo.nombre),
                  )
                : Container(),
            museo.direccion?.isNotEmpty ?? false
                ? ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text(museo.direccion),
                  )
                : Container(),
            museo.horarios?.isNotEmpty ?? false
                ? ListTile(
                    leading: Icon(Icons.schedule),
                    title: Text(museo.horarios),
                  )
                : Container(),
            museo.contacto?.isNotEmpty ?? false
                ? ListTile(
                    leading: Icon(Icons.phone),
                    title: Text(museo.contacto),
                  )
                : Container(),
            museo.email?.isNotEmpty ?? false
                ? ListTile(
                    leading: Icon(Icons.email),
                    title: Text(museo.email),
                  )
                : Container(),
            museo.precios?.isNotEmpty ?? false
                ? ListTile(
                    leading: Icon(Icons.euro),
                    title: Text(museo.precios),
                  )
                : Container(),
            museo.url?.isNotEmpty ?? false
                ? ListTile(
                    leading: Icon(Icons.public),
                    title: Text(museo.url),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
