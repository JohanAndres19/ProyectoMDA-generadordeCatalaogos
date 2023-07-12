import 'component.dart';

abstract class BuilderComponent<T> {
  List<Component>? _listaDeComponentes;
  set componentes(var c) => _listaDeComponentes = c;

  List<Component>? get componentes => _listaDeComponentes;
  createComponent(T a);

  createJson(var a);
}

class BuilderComponentItem<Object> extends BuilderComponent {
  @override
  createComponent(a) {
    var listItems = [];
    var listJson = createJson(a);
    for (var value in listJson) {
      listItems.add({value.keys.toList()[0]:Item.fromJson(value[value.keys.toList()[0]])});
    }
    return listItems;
  }

  @override
  createJson(a) {
    var listJson = [];
    for (var i in a.keys) {
      if (i != 'structure') {
        var json = {'array': []};
        for (var j in a[i].keys) {
          json['array']?.add(<String, dynamic>{'tipo': j, 'value': a[i][j].toString()});
        }
        listJson.add({i:json});
      }
    }
    return listJson;
  }
}

class BuilderComponentColeccion<Object> extends BuilderComponent {
  @override
  createComponent(a) {
    var listColecciones = [];
    var listJson = createJson(a);
    for (var value in listJson) {
      listColecciones.add({value.keys.toList()[0]:Coleccion.fromJson(value[value.keys.toList()[0]])});
    }
    return listColecciones;
  }

  @override
  createJson(a) {
    var listJson = [];
    for (var i in a['json'].keys) {
      if (i != 'structure') {
        var json = {'array': []};
        for (var j in a['json'][i].keys) {
          if(j!='Components'){
            json['array']?.add(<String, dynamic>{'tipo': j, 'value': a['json'][i][j].toString()});
          }else{
            json['array']?.add(<String, dynamic>{'tipo': j, 'value': List.generate(a['json'][i][j]?.length, (index) => a['json'][i][j][index])});
          }
        }
        json['componentes']=<Component>[];
        for (var element in a['items']) {
          if(a['json'][i]['Components'].contains(element.keys.toList()[0])){
              json['componentes']?.add(element[element.keys.toList()[0]]);
          }
        }       
        listJson.add({i:json});
      }
    }
    return listJson;
  }
}

class BuilderComponentSColeccion<Object> extends BuilderComponent {
  @override
  createComponent(a) {
    var listColecciones = [];
    var listJson = createJson(a);
    for (var value in listJson) {
      listColecciones.add({value.keys.toList()[0]:SuperColeccion.fromJson(value[value.keys.toList()[0]])});
    }
    return listColecciones;
  }

  @override
  createJson(a) {
    var listJson = [];
    for (var i in a['json'].keys) {
      if (i != 'structure') {
        var json = {'array': []};
        for (var j in a['json'][i].keys) {
          if(j!='Colecciones'){
            json['array']?.add(<String, dynamic>{'tipo': j, 'value': a['json'][i][j].toString()});
          }else{
            json['array']?.add(<String, dynamic>{'tipo': j, 'value': List.generate(a['json'][i][j]?.length, (index) => a['json'][i][j][index])});
          }
        }
        json['componentes']=<Component>[];
        for (var element in a['colecciones']) {
          if(a['json'][i]['Colecciones'].contains(element.keys.toList()[0])){
              json['componentes']?.add(element[element.keys.toList()[0]]);
          }
        }       
        listJson.add({i:json});
      }
    }
    return listJson;
  }
}
