import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hasanat/shared/widgets/gradient_button.dart';

void main() {
  testWidgets('GradientButton label ko\'rsatadi va bosishga javob beradi',
      (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: GradientButton(
            label: 'Boshlash',
            onPressed: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('Boshlash'), findsOneWidget);

    await tester.tap(find.byType(GradientButton));
    await tester.pumpAndSettle();

    expect(tapped, isTrue);
  });
}
