import 'package:collection/collection.dart';

import 'package:buildercatalogoweb/LCatalogo/catalogo.dart';

///Clase que se encarga de decodificar el formulario y revisar la structura
class Form {

  // variable qu almacena el formulario en forma de Mapa
  Map<String, dynamic>? _form;

  verificarForm() {
    /**
     * Metodo que verifica que el 'formulario '
     * contiene la estructura establecida 
     * con base a las etiquetas creadas 
     */
    var structures = getForm!['structures'];//structura definida para los Items, Colecciones y SuperColecciones
    var values = getForm!['values'];// valores creados con base a las estructuras definidas 
    var verificado = false;
    for (var element in values.keys) {
      var datos = values[element];
      var keys = datos.keys.toList();
      var struc = keys.removeAt(0);
      var scompa = structures?[datos[struc]];
      for (var element in keys) {
        if (element != struc) {
          var valoresItem = datos[element];
          var valorkeys = valoresItem.keys.toList();
          verificado = ListEquality().equals(valorkeys, scompa.keys.toList());
          if (!verificado) {
            break;
          }
        }
      }
      if (!verificado) {
        break;
      }
    }
    if (!verificado) {
      return false;
    }
    return true;
  }

  verificarFiltro(){
    
  }

  cargarForm() {
    Director director = Director(BuilderCatalogoConcreto());
    director.setform = getForm;
    director.make();
  }

  set setform(var a) => _form = a;

  Map<String, dynamic>? get getForm => _form;
}

/// Clase que se encarga de realizar la construccion del catalogo
/// con base en el formulario llenado
class Director {
  BuilderCatalogo? builderCatalogo;

  Map<String, dynamic>? _form;

  Director(BuilderCatalogo catalogo) {
    builderCatalogo = catalogo;
  }

  set setform(var a) => _form = a;

  Map<String, dynamic>? get getForm => _form;

  BuilderCatalogo? get getBuilderCatalogo => builderCatalogo;

  make() {
    builderCatalogo?.crearCatalogo(getForm);
  }
}
