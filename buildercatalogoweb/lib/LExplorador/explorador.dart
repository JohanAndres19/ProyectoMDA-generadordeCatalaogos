import 'dart:math';

import 'package:buildercatalogoweb/LExplorador/builder_filtro.dart';
import 'package:buildercatalogoweb/LExplorador/filtro.dart';

class Explorador  {
  List<Filtro>? _filtro;

  set setFiltro( var a )=> _filtro=a;
  List<Filtro>? get getFiltro => _filtro;
}

abstract class BuilderExplorador<T> {
  Explorador? explorador;
  BuilderFiltro? builderFiltro;
  
  createExplorador(T a);
  
  Explorador? get getExplorador => explorador; 


}

class BuilderExploradorConcreto<Object> extends BuilderExplorador {
  
  
  @override
  createExplorador(a) {
    List<Filtro> filtros=[];
    for (var element in a['a']['Filtros'].keys) {
      switch (element) {
        case 'FiltroItem':
          builderFiltro = BuilderFiltroItem();
          filtros.add(builderFiltro?.crearFiltro([a['a']['Filtros'][element],a['componentes']['items']]));
          break;
        case 'FiltroColeccion':
          builderFiltro = BuilderFiltroColeccion();
          filtros.add(builderFiltro?.crearFiltro([a['a']['Filtros'][element],a['componentes']['colecciones']]));  
          break;
        case 'FiltroSColeccion':
          builderFiltro = BuilderFiltroSColeccion();
          filtros.add(builderFiltro?.crearFiltro([a['a']['Filtros'][element],a['componentes']['supercolecciones']]));
          break;
        default:
      }
    }
    explorador=Explorador();
    explorador?.setFiltro=filtros;
    return explorador;
  }
  
}
