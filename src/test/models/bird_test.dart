
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:honeybird/models/bird.dart';

void main() {
	group('Bird Model Test', () {
		test('Bird model should serialize and deserialize correctly', () {
			const birdJson = {
				'name': 'Sparrow',
				'description': 'A small, plump, brown and grey bird.',
				'imageUrl': 'http://example.com/sparrow.png'
			};

			final bird = Bird(
				name: 'Sparrow',
				description: 'A small, plump, brown and grey bird.',
				imageUrl: 'http://example.com/sparrow.png',
			);

			// Test serialization
			expect(bird.toJson(), birdJson);

			// Test deserialization
			final birdFromJson = Bird.fromJson(birdJson);
			expect(birdFromJson.name, 'Sparrow');
			expect(birdFromJson.description, 'A small, plump, brown and grey bird.');
			expect(birdFromJson.imageUrl, 'http://example.com/sparrow.png');
		});

		test('Bird model should have correct properties', () {
			final bird = Bird(
				name: 'Robin',
				description: 'A small bird with a red chest.',
				imageUrl: 'http://example.com/robin.png',
			);

			expect(bird.name, 'Robin');
			expect(bird.description, 'A small bird with a red chest.');
			expect(bird.imageUrl, 'http://example.com/robin.png');
		});
	});
}
