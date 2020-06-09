import 'package:flutter/foundation.dart';
import 'explosao_exception.dart';

class Campo {
  final int linha;
  final int coluna;

  List<Campo> vizinhos = [];

  bool _aberto = false;
  bool _minado = false;
  bool _marcado = false;
  bool _explodido = false;

  Campo({
    @required this.linha,
    @required this.coluna,
  });

  void adicionarVizinho(Campo possivelVizinho) {
    var linhaDiff = (linha - possivelVizinho.linha).abs();
    var colunaDiff = (coluna - possivelVizinho.coluna).abs();

    if (linhaDiff == 0 && colunaDiff == 0) {
      return;
    }

    if (linhaDiff <= 1 && colunaDiff <= 1) {
      vizinhos.add(possivelVizinho);
    }
  }

  bool get minado {
    return _minado;
  }

  bool get aberto {
    return _aberto;
  }

  bool get marcado {
    return _marcado;
  }

  bool get explodido {
    return _explodido;
  }

  void abrir() {
    if (_aberto) {
      return;
    }

    _aberto = true;

    if (_minado) {
      _explodido = true;
      throw ExplosaoException();
    }

    if (vizinhancaSegura) {
      vizinhos.forEach((v) => v.abrir());
    }
  }

  void alternarMarcacao() {
    _marcado = !_marcado;
  }

  void reiniciar() {
    _aberto = false;
    _minado = false;
    _marcado = false;
    _explodido = false;
  }

  void minar() {
    _minado = true;
  }

  void revelarBomba() {
    if (_minado) {
      _aberto = true;
    }
  }

  bool get vizinhancaSegura {
    return vizinhos.every((v) => !v.minado);
  }

  int get qtdeMinasNaVizinhanca {
    return vizinhos.where((v) => v.minado).length;
  }

  bool get resolvido {
    bool minadoEMarcado = minado && marcado;
    bool seguroEAberto = !minado && aberto;
    return minadoEMarcado || seguroEAberto;
  }
}
