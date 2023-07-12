import 'package:buildercatalogoweb/LExplorador/filtro.dart';

abstract class BuilderFiltro <T>{
  Filtro ? filtro;

  crearFiltro(T a);

}

class BuilderFiltroItem extends BuilderFiltro {
  @override
  crearFiltro(a) {
    filtro =FitroItem();
    Map<String,dynamic> json={};
    for (var element in a[0]) {
      json[element.toString()]={};
    } 
    for (var element in a[1]) {
      var instance=element[element.keys.toList()[0]];
      for (var j in instance.getAtributos){
          if(json.keys.contains(j.tipo)){
            if(!json[j.tipo].keys.contains(j.value)){
              json[j.tipo][j.value]=[element.keys.toList()[0]];
            }else{
              json[j.tipo][j.value].add(element.keys.toList()[0]);
            }
          } 
      }
    } 
    var diccionario =Diccionario();
    diccionario.setDicc=json;
    filtro?.setDiccionario=diccionario;
    return filtro;
  }
  
}

class BuilderFiltroColeccion extends BuilderFiltro {
  @override
  crearFiltro(a) {
    filtro =FiltroColeccion();
    Map<String,dynamic> json={};
    for (var element in a[0]) {
      json[element.toString()]={};
    } 
    for (var element in a[1]) {
      var instance=element[element.keys.toList()[0]];
      for (var j in instance.getAtributos){
          if(json.keys.contains(j.tipo)){
            if(!json[j.tipo].keys.contains(j.value)){
              json[j.tipo][j.value]=[element.keys.toList()[0]];
            }else{
              json[j.tipo][j.value].add(element.keys.toList()[0]);
            }
          } 
      }
    } 
    var diccionario =Diccionario();
    diccionario.setDicc=json;
    filtro?.setDiccionario=diccionario;
    return filtro;

  }
  
}

class BuilderFiltroSColeccion extends BuilderFiltro {
  @override
  crearFiltro(a) {
    filtro =FiltroSColeccion();
    Map<String,dynamic> json={};
    for (var element in a[0]) {
      json[element.toString()]={};
    } 
    for (var element in a[1]) {
      var instance=element[element.keys.toList()[0]];
      for (var j in instance.getAtributos){
          if(json.keys.contains(j.tipo)){
            if(!json[j.tipo].keys.contains(j.value)){
              json[j.tipo][j.value]=[element.keys.toList()[0]];
            }else{
              json[j.tipo][j.value].add(element.keys.toList()[0]);
            }
          } 
      }
    }     
    var diccionario =Diccionario();
    diccionario.setDicc=json;
    filtro?.setDiccionario=diccionario;
    return filtro;
  }
  
}