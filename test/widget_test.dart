import 'package:flutter_test/flutter_test.dart';
import 'package:football_quiz/main.dart';

void main() {
  testWidgets('FootQuiz app launches successfully',
          (WidgetTester tester) async {
        await tester.pumpWidget(const FootQuizApp());

        expect(find.text('Welcome to Football Quiz!'), findsOneWidget);
        expect(find.text('LOGIN'), findsOneWidget);
      });
}
