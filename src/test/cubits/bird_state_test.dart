
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:honeybird/cubits/bird_state.dart';
import 'package:honeybird/models/bird.dart';

class MockBird extends Mock implements Bird {}

void main() {
	group('BirdState Tests', () {
		group('BirdInitial', () {
			test('supports value comparisons', () {
				expect(BirdInitial(), BirdInitial());
			});
		});

		group('BirdLoading', () {
			test('supports value comparisons', () {
				expect(BirdLoading(), BirdLoading());
			});
		});

		group('BirdLoaded', () {
			final bird = MockBird();

			test('supports value comparisons', () {
				expect(BirdLoaded([bird]), BirdLoaded([bird]));
			});

			test('props are correct', () {
				expect(BirdLoaded([bird]).props, [[bird]]);
			});
		});

		group('BirdError', () {
			const errorMessage = 'Something went wrong';

			test('supports value comparisons', () {
				expect(BirdError(errorMessage), BirdError(errorMessage));
			});

			test('props are correct', () {
				expect(BirdError(errorMessage).props, [errorMessage]);
			});
		});
	});
}
