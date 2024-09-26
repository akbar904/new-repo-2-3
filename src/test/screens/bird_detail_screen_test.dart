
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:honeybird/screens/bird_detail_screen.dart';
import 'package:honeybird/models/bird.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
	group('BirdDetailScreen Widget Tests', () {
		late Bird testBird;
		late MockNavigatorObserver mockObserver;

		setUp(() {
			testBird = Bird(
				name: 'Test Bird',
				description: 'A bird used for testing',
				imageUrl: 'http://example.com/bird.jpg',
			);
			mockObserver = MockNavigatorObserver();
		});

		testWidgets('displays bird name', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(
				home: BirdDetailScreen(bird: testBird),
				navigatorObservers: [mockObserver],
			));

			expect(find.text('Test Bird'), findsOneWidget);
		});

		testWidgets('displays bird description', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(
				home: BirdDetailScreen(bird: testBird),
				navigatorObservers: [mockObserver],
			));

			expect(find.text('A bird used for testing'), findsOneWidget);
		});

		testWidgets('displays bird image', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(
				home: BirdDetailScreen(bird: testBird),
				navigatorObservers: [mockObserver],
			));

			expect(find.byType(Image), findsOneWidget);
			final Image image = tester.widget(find.byType(Image));
			expect(image.image.toString(), contains('http://example.com/bird.jpg'));
		});
	});
}
