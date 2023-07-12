import 'dart:convert';
import 'dart:io';

import 'package:buildercatalogoweb/LComponentes/builder_componente.dart';
import 'package:buildercatalogoweb/LComponentes/component.dart';
import 'package:buildercatalogoweb/LExplorador/explorador.dart';
import 'package:buildercatalogoweb/LExplorador/filtro.dart';
import 'package:json_annotation/json_annotation.dart';

/// Clase abstracta que representa la estructura del
/// constructor del catalogo
abstract class BuilderCatalogo<T> {
  Catalogo? catalogo;
  BuilderExplorador? builderExplorador;
  BuilderComponent? builderComponent;

  Catalogo? get getCatalogo => catalogo;

  crearComponent(T a);
  crearExplorador(T a);
  crearCatalogo(T a);
}

class BuilderCatalogoConcreto<Object> extends BuilderCatalogo {
  @override
  crearCatalogo(a) {
    var jsonclass=crearComponent(a);
    Explorador explorador=crearExplorador({'a':a,'componentes':jsonclass});
    Map<String,dynamic> catalogoJson={};
    catalogoJson['componentes']={};
    for (var element in jsonclass.keys) {
        catalogoJson['componentes'][element]={};
        for(var j in jsonclass[element]){
          if(element=='items'){
            catalogoJson['componentes'][element][j.keys.toList()[0]]=j[j.keys.toList()[0]].toJson();
          }else{
            catalogoJson['componentes'][element][j.keys.toList()[0]]=j[j.keys.toList()[0]].toJson();
          }
        }
    }
    catalogoJson['Explorador']={};
    // ignore: unused_local_variable
    var getFiltro = explorador.getFiltro;
    getFiltro?.forEach((element) { 
      if (element is FitroItem) {
        catalogoJson['Explorador'].addAll({'FiltroItem':element.getDiccionario?.getDicc});
      }else if (element is FiltroColeccion){
        catalogoJson['Explorador'].addAll({'FiltroColecccion':element.getDiccionario?.getDicc});
      }else if(element is FiltroSColeccion){
        catalogoJson['Explorador'].addAll({'FiltroSColeccion':element.getDiccionario?.getDicc});
      }
    });
    print(catalogoJson);
    String jsonFinal = jsonEncode(catalogoJson);
    File file  = File('lib/jsonprueba/catalogo.json');
    file.writeAsStringSync(jsonFinal);
  }

  @override
  crearComponent(a) {
    var listItems = [];
    var listColecciones = [];
    var listSColecciones=[];
    for (var element in a['values'].keys) {
      switch (element) {
        case 'Items':
          builderComponent = BuilderComponentItem();
          var i = builderComponent?.createComponent(a['values'][element]);
          listItems.addAll(i);
          break;
        case 'Colecciones':
          builderComponent = BuilderComponentColeccion();
          var i = builderComponent?.createComponent(
              {'json': a['values'][element], 'items': listItems});
          listColecciones.addAll(i);
          break;
        case 'SuperColecciones':
          builderComponent = BuilderComponentSColeccion();
          var i = builderComponent?.createComponent(
              {'json': a['values'][element], 'colecciones': listColecciones});
          listSColecciones.addAll(i);
          break;
        default:
      }
    }
    return {'items':listItems,'colecciones':listColecciones,'supercolecciones':listSColecciones};
  }

  @override
  crearExplorador(a) {
   builderExplorador =BuilderExploradorConcreto();
   return builderExplorador?.createExplorador(a);
  }
}

/// clase que representa el objeto Catalogo
@JsonSerializable()
class Catalogo {
  Explorador? _explorador;
  List<Item>? _items;
  List<Coleccion>? _colecciones;
  List<SuperColeccion>? _supercolecciones;

  //getters
  Explorador? get getExplorador => _explorador;
  List<Item>? get getItems => _items;
  List<Coleccion>? get getColecciones => _colecciones;
  List<SuperColeccion>? get getSuperColecciones => _supercolecciones;
  //
  //setters
  set setExplorador(var a) => _explorador=a;
  set setItems(var a)=> _items=a;
  set setColecciones(var a)=>_colecciones=a;

}
