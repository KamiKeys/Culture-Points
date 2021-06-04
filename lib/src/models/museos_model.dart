class Museos {
  List<Museo> items = [];

  Museos();

  Museos.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final museo = new Museo.fromJsonMap(item);
      items.add(museo);
    }
  }
}

class Museo {
  int recordId;
  String titularidad;
  String contacto;
  double latitud;
  double longitud;
  String url;
  String precios;
  String accesopmr;
  String infoesp;
  String tarjetajoven;
  String fid;
  String nombre;
  String descripcion;
  String horarios;
  int id;
  String direccion;
  String email;

  Museo({
    this.recordId,
    this.titularidad,
    this.contacto,
    this.latitud,
    this.longitud,
    this.url,
    this.precios,
    this.accesopmr,
    this.infoesp,
    this.tarjetajoven,
    this.fid,
    this.nombre,
    this.descripcion,
    this.horarios,
    this.id,
    this.direccion,
    this.email,
  });

  Museo.fromJsonMap(Map<String, dynamic> json) {
    recordId = json['_id'];
    titularidad = json['TITULARIDAD'];
    contacto = json['CONTACTO'];
    latitud = double.parse((json['SDOGEOMETRIA'] as String)
        .substring(7, (json['SDOGEOMETRIA'] as String).length - 1)
        .split(" ")[1]);
    longitud = double.parse((json['SDOGEOMETRIA'] as String)
        .substring(7, (json['SDOGEOMETRIA'] as String).length - 1)
        .split(" ")[0]);
    url = json['URL'];
    precios = json['PRECIOS'];
    accesopmr = json['ACCESOPMR'];
    infoesp = json['INFOESP'];
    tarjetajoven = json['TARJETAJOVEN'];
    fid = json['FID'];
    nombre = json['NOMBRE'];
    descripcion = json['DESCRIPCION'];
    horarios = json['HORARIOS'];
    id = json['ID'];
    direccion = json['DIRECCION'];
    email = json['EMAIL'];
  }
}
