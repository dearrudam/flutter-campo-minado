import 'package:campo_minado/models/tabuleiro.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Tabuleiro', () {
    var criarTabuleiro = () {
      Tabuleiro tabuleiro = Tabuleiro(
        linhas: 2,
        colunas: 2,
        qtdeBombas: 0,
      );

      tabuleiro.campos[0].minar();
      tabuleiro.campos[1].minar();
      return tabuleiro;
    };

    test('Ganhando Jogo 1', () {
      Tabuleiro tabuleiro = criarTabuleiro();

      // Jogando

      tabuleiro.campos[0].alternarMarcacao();
      tabuleiro.campos[1].alternarMarcacao();
      tabuleiro.campos[2].abrir();
      tabuleiro.campos[3].abrir();

      expect(tabuleiro.resolvido, true);
    });

    test('Perdendo Jogo 2', () {
      Tabuleiro tabuleiro = criarTabuleiro();
      try {
        // Jogando
        tabuleiro.campos[0].abrir();
        fail('deveria ter lançado uma exceção indicando que o campo explodiu!');
      } catch (e) {}
      expect(tabuleiro.resolvido, false);
    });

    test('Perdendo Jogo 3', () {
      Tabuleiro tabuleiro = criarTabuleiro();

      // Jogando
      try {
        tabuleiro.campos[0].alternarMarcacao();
        tabuleiro.campos[1].abrir();
        fail('deveria ter lançado uma exceção indicando que o campo explodiu!');
      } catch (e) {}
      expect(tabuleiro.resolvido, false);
    });
  });
}
