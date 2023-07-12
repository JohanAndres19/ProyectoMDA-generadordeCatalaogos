class Diccionario {
  Map<String, dynamic>? _dicc;


  removeValor({var key}){
    _dicc?.remove(key);
  }

  Map<String, dynamic>? get getDicc=> _dicc;
  set setDicc(var a)=> _dicc=a;
}

abstract class Filtro {
  Diccionario? diccionario;
  String? buscador;

  set setDiccionario( var a) => diccionario=a;
  set setBuscar(var a)=> buscador=a;
  
  String? get getBuscar=> buscador;
  Diccionario? get getDiccionario => diccionario;  
  
  
  filtar();
  buscar();
}

class FitroItem extends Filtro {


  @override
  buscar() {
    // TODO: implement buscar
    throw UnimplementedError();
  }

  @override
  filtar() {
    // TODO: implement filtar
    throw UnimplementedError();
  }
}

class FiltroColeccion extends Filtro {
  @override
  buscar() {
    // TODO: implement buscar
    throw UnimplementedError();
  }

  @override
  filtar() {
    // TODO: implement filtar
    throw UnimplementedError();
  }
}

class FiltroSColeccion extends Filtro {
  @override
  buscar() {
    // TODO: implement buscar
    throw UnimplementedError();
  }

  @override
  filtar() {
    // TODO: implement filtar
    throw UnimplementedError();
  }
}
