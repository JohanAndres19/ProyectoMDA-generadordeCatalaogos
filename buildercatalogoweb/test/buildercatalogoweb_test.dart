import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:test/test.dart';
import 'package:buildercatalogoweb/form.dart';

void main() {
  Form form1 = Form();
  test('ValidandoFormulario', () {
    File file = File('/home/johan/Documentos/Universidad/Tendencias/Proyecto/buildercatalogoweb/lib/jsonprueba/prueba.yaml');
    String fileContent = file.readAsStringSync();
    var yamlMap = loadYaml(fileContent);
    form1.setform=Map<String, dynamic>.from(yamlMap);
    expect(form1.verificarForm(), true);
  });

  test('Cargar formulario Valores', () {
    File file = File('/home/johan/Documentos/Universidad/Tendencias/Proyecto/buildercatalogoweb/lib/jsonprueba/prueba.yaml');
    String fileContent = file.readAsStringSync();
    var yamlMap = loadYaml(fileContent);
    form1.setform=Map<String, dynamic>.from(yamlMap);
    form1.cargarForm();
    expect(true, true); 
  });

  test('',(){
    
  });
} 
