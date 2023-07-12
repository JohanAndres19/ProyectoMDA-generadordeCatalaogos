import 'package:json_annotation/json_annotation.dart';

part 'component.g.dart';


/// Interface que permite generalizar el componente y sus funcionalidades

abstract class Component {
  List<Etiqueta>? _atributos;
  addAtributos(Etiqueta e);

}

/// Clase abstracta que define la estructura general del elemento compuesto
/// (Super coleccion y coleccion)

abstract class Compuesto implements Component {
  
  @JsonKey(fromJson: getAtributosJson, toJson: toJsonAtributos)
  List<Etiqueta>? _atributos;

  @JsonKey(fromJson:getComponentesJson ,toJson: toJsonComponentes )
  List<Component>? componentes;
  
  static  toJsonAtributos(var a) => a.map((e)=>e.toJson()).toList() ;
  
  static List<Etiqueta>? getAtributosJson(var a) => List<Etiqueta>.generate(a.length,(index) => Etiqueta.fromJson(a[index] as Map<String,dynamic>));
  
  static List<Component>? getComponentesJson(var a)=>a;
  
  static dynamic toJsonComponentes(var a) => a.map((e)=>e.toJson()).toList();  
  

  @override
  addAtributos(Etiqueta e) {
    if (getAtributos == null) {
      _atributos = [];
    }
    getAtributos?.add(e);
  }
  addComponent(Component e) {
    if(getComponentes==null){
      componentes=[];
    }
    componentes?.add(e);
  }

  set setComponentes(var c) => componentes = c;

  set setAtributos(var a) => _atributos = a ;

  List<Component>? get getComponentes => componentes;

  List<Etiqueta>? get getAtributos => _atributos;
}



// clase compuesta concreta que indica el primer nivel de jerarquia
@JsonSerializable()
class Coleccion extends Compuesto {

  Coleccion();
  factory Coleccion.fromJson(var a)=>_$ColeccionFromJson(a);

  Map<String, dynamic> toJson() => _$ColeccionToJson(this);
}

@JsonSerializable()
class SuperColeccion extends Compuesto {
  
  SuperColeccion();

  factory SuperColeccion.fromJson(var a)=>_$SuperColeccionFromJson(a);

  Map<String, dynamic> toJson() => _$SuperColeccionToJson(this);

}



/// Clase hoja que define el componente mas simple
@JsonSerializable()
class Item implements Component {
  
  @override
  List<Etiqueta>? _atributos;

  Item({var array}){
    _atributos=array;
  }
  
  factory Item.fromJson(var a) => _$ItemFromJson(a);

  Map<String, dynamic> toJson() => _$ItemToJson(this);

  List<Etiqueta>? get getAtributos => _atributos;
  set setAtributos(var a) => _atributos = a;

  
  @override
  addAtributos(Etiqueta e) {
    if (getAtributos == null) {
      _atributos = [];
    }
    getAtributos?.add(e);
  }

  
}

/// Clase que nos permite dar atributos a los elementos
/// y o componentes

@JsonSerializable()
class Etiqueta {
  String? _tipo;
  
  Object? _value;

  Etiqueta();

  factory Etiqueta.fromJson(var a) => _$EtiquetaFromJson(a);

  Map<String, dynamic> toJson() => _$EtiquetaToJson(this);

  set tipo(var a) => _tipo = a;
  set value(var a) => _value = a;
  String? get tipo => _tipo;
  Object? get value => _value;
}



