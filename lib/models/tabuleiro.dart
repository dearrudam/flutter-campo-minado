import 'dart:math';

import 'package:campo_minado/models/campo.dart';
import 'package:flutter/foundation.dart';

class Tabuleiro {

  final int linhas;
  final int colunas;
  final int qtdeBombas;

  final List<Campo> _campos = [];

  Tabuleiro({
    @required this.linhas,
    @required this.colunas,
    @required this.qtdeBombas,
  }) {
    _popularTabuleiro();
    _relacionarCampos();
    _sortearMinas();
  }

  void _popularTabuleiro() {
    for (var linha = 0; linha < linhas; linha++) {
      for (var coluna = 0; coluna < colunas; coluna++) {
        _campos.add(Campo(linha: linha, coluna: coluna));
      }
    }
  }

  void _relacionarCampos() {
    for (var campo in _campos) {
      for (var vizinho in _campos) {
        campo.adicionarVizinho(vizinho);
      }
    }
  }

  void _sortearMinas() {
    int numeroDeBombasSortedas = 0;
    if (qtdeBombas > (linhas * colunas)) {
      return;
    }
    while (numeroDeBombasSortedas < qtdeBombas) {
      var indiceSorteado = Random().nextInt(_campos.length);

      if (!_campos[indiceSorteado].minado) {
        _campos[indiceSorteado].minar();
        numeroDeBombasSortedas++;
      }
    }
  }

  void reiniciar() {
    _campos.forEach((campo) => campo.reiniciar());
    _sortearMinas();
  }

  void revelarBombas() {
    _campos.forEach((campo) => campo.revelarBomba());
  }

  List<Campo> get campos {
    return _campos;
  }

  bool get resolvido {
    return _campos.every((campo) => campo.resolvido);
  }
}
