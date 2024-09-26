
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:honeybird/widgets/bird_list_item.dart';
import 'package:honeybird/models/bird.dart';

class FakeBird extends Fake implements Bird {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeBird());
  });

  group('BirdListItem Widget Tests', () {
    testWidgets('displays bird name and description', (WidgetTester tester) async {
      // Arrange
      final bird = Bird(
        name: 'Golden Eagle',
        description: 'A large bird of prey.',
        imageUrl: 'https://example.com/golden_eagle.jpg',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BirdListItem(bird),
          ),
        ),
      );

      // Assert
      expect(find.text('Golden Eagle'), findsOneWidget);
      expect(find.text('A large bird of prey.'), findsOneWidget);
    });

    testWidgets('displays bird image', (WidgetTester tester) async {
      // Arrange
      final bird = Bird(
        name: 'Golden Eagle',
        description: 'A large bird of prey.',
        imageUrl: 'https://example.com/golden_eagle.jpg',
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BirdListItem(bird),
          ),
        ),
      );

      // Assert
      expect(find.byType(Image), findsOneWidget);
      final image = tester.widget<Image>(find.byType(Image));
      expect(image.image, isA<NetworkImage>());
      expect((image.image as NetworkImage).url, 'https://example.com/golden_eagle.jpg');
    });
  });
}
