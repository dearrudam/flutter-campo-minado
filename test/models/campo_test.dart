import 'package:campo_minado/models/campo.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  group('Campo', () {
    test('Abrir Campo marcado para explodir', () {
      Campo c = Campo(linha: 0, coluna: 0);
      c.minar();
      expect(c.abrir, throwsException);
    });
    test('Abrir Campo marcado para não explodir', () {
      Campo c = Campo(linha: 0, coluna: 0);
      c.abrir();
      expect(c.aberto, isTrue);
    });

    test('Adicionar Campo que não é vizinho', () {
      Campo c = Campo(linha: 0, coluna: 0);
      Campo naoVizinho = Campo(linha: 1, coluna: 3);

      c.adicionarVizinho(naoVizinho);
      expect(c.vizinhos.isEmpty, isTrue);

      naoVizinho = Campo(linha: 0, coluna: 0);
      c.adicionarVizinho(naoVizinho);
      expect(c.vizinhos.isEmpty, isTrue);

      naoVizinho = Campo(linha: 3, coluna: 1);
      c.adicionarVizinho(naoVizinho);
      expect(c.vizinhos.isEmpty, isTrue);
    });

    test('Adicionar Campo que é vizinho', () {
      Campo l0c0 = Campo(linha: 0, coluna: 0);
      Campo l0c1 = Campo(linha: 0, coluna: 1);
      Campo l0c2 = Campo(linha: 0, coluna: 2);

      Campo l1c0 = Campo(linha: 1, coluna: 0);
      Campo l1c1 = Campo(linha: 1, coluna: 1);
      Campo l1c2 = Campo(linha: 1, coluna: 2);

      Campo l2c0 = Campo(linha: 2, coluna: 0);
      Campo l2c1 = Campo(linha: 2, coluna: 1);
      Campo l2c2 = Campo(linha: 2, coluna: 2);

      Campo l3c0 = Campo(linha: 3, coluna: 0);
      Campo l3c1 = Campo(linha: 3, coluna: 1);
      Campo l3c2 = Campo(linha: 3, coluna: 2);
      
      // (0,0)  (0,1)  (0,2)
      // (1,0)  (1,1)  (1,2)
      // (2,0)  (2,1)  (2,2)
      // (3,0)  (3,1)  (3,2)

      l1c1.adicionarVizinho(l0c0);
      l1c1.adicionarVizinho(l0c1);
      l1c1.adicionarVizinho(l0c2);

      l1c1.adicionarVizinho(l1c0);
      l1c1.adicionarVizinho(l1c2);

      l1c1.adicionarVizinho(l2c0);
      l1c1.adicionarVizinho(l2c1);
      l1c1.adicionarVizinho(l2c2);

      l1c1.adicionarVizinho(l3c0);
      l1c1.adicionarVizinho(l3c1);
      l1c1.adicionarVizinho(l3c2);

      expect(l1c1.vizinhos.length, 8);
    });

    test('Minas na vizinhança', () {
      Campo l0c0 = Campo(linha: 0, coluna: 0);
      Campo l0c1 = Campo(linha: 0, coluna: 1);
      Campo l0c2 = Campo(linha: 0, coluna: 2);

      Campo l1c0 = Campo(linha: 1, coluna: 0);
      Campo l1c1 = Campo(linha: 1, coluna: 1);
      Campo l1c2 = Campo(linha: 1, coluna: 2);

      Campo l2c0 = Campo(linha: 2, coluna: 0);
      Campo l2c1 = Campo(linha: 2, coluna: 1);
      Campo l2c2 = Campo(linha: 2, coluna: 2);

      Campo l3c0 = Campo(linha: 3, coluna: 0);
      Campo l3c1 = Campo(linha: 3, coluna: 1);
      Campo l3c2 = Campo(linha: 3, coluna: 2);


      l0c1.minar();

      l2c1.minar();

      l3c2.minar();

      // (0,0)  (0,1)* (0,2)
      // (1,0)  (1,1)  (1,2)
      // (2,0)  (2,1)* (2,2)
      // (3,0)  (3,1)  (3,2)*

      l1c1.adicionarVizinho(l0c0);
      l1c1.adicionarVizinho(l0c1);
      l1c1.adicionarVizinho(l0c2);

      l1c1.adicionarVizinho(l1c0);
      l1c1.adicionarVizinho(l1c2);

      l1c1.adicionarVizinho(l2c0);
      l1c1.adicionarVizinho(l2c1);
      l1c1.adicionarVizinho(l2c2);

      l1c1.adicionarVizinho(l3c0);
      l1c1.adicionarVizinho(l3c1);
      l1c1.adicionarVizinho(l3c2);

      expect(l1c1.qtdeMinasNaVizinhanca, 2);
    });
  });
}
