// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'component.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperColeccion _$SuperColeccionFromJson(Map<String, dynamic> json){
  SuperColeccion s =SuperColeccion();
  s.componentes =Compuesto.getComponentesJson(json['componentes'] as List<Component>);
  s.setAtributos =Compuesto.getAtributosJson(json['array']);
  return s;
}

Map<String,dynamic> _$SuperColeccionToJson(SuperColeccion instance) =><String,dynamic>{
  'componentes': instance.getComponentes,
  'array':Compuesto.toJsonAtributos(instance.getAtributos)
};

Coleccion _$ColeccionFromJson(Map<String, dynamic> json) { 
  Coleccion c = Coleccion();
  c.componentes =Compuesto.getComponentesJson(json['componentes'] as List<Component>) ;
  c.setAtributos= Compuesto.getAtributosJson(json['array'] ); 
  return c;
}

Map<String, dynamic> _$ColeccionToJson(Coleccion instance) => <String, dynamic>{
      'componentes': Compuesto.toJsonComponentes(instance.componentes),
      'array':Compuesto.toJsonAtributos(instance.getAtributos),
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
  array: (json['array'] as List<dynamic>).map((e) => Etiqueta.fromJson(e as Map<String,dynamic>)).toList());

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
  'array':instance.getAtributos?.map((e) => e.toJson()).toList()
};

Etiqueta _$EtiquetaFromJson(Map<String, dynamic> json) => Etiqueta()
  ..tipo = json['tipo'] as String?
  ..value = json['value'];

Map<String, dynamic> _$EtiquetaToJson(Etiqueta instance) => <String, dynamic>{
      'tipo': instance.tipo,
      'value': instance.value,
    };
