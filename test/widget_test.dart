import 'package:flutter_test/flutter_test.dart';
import 'package:mamamia_pizzaria/main.dart';

void main() {
  testWidgets('Verifica se a tela de login contém o botão ENTRAR', (WidgetTester tester) async {
    // Constrói a aplicação e exibe a tela inicial (LoginPage).
    await tester.pumpWidget(const MyApp());

    // Verifica se o botão "ENTRAR" está presente.
    expect(find.text('ENTRAR'), findsOneWidget);
    expect(find.text('MENU'), findsOneWidget);

    // Tenta fazer um clique no botão "ENTRAR".
    await tester.tap(find.text('ENTRAR'));
    await tester.pump();  // Rebuilds the widget after the tap.

    // Você pode adicionar mais verificações aqui, por exemplo, se alguma
    // navegação ocorreu ou se alguma mensagem de erro aparece.
  });
}
