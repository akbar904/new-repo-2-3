
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:honeybird/cubits/bird_cubit.dart';
import 'package:honeybird/cubits/bird_state.dart';
import 'package:honeybird/models/bird.dart';

class MockBirdRepository extends Mock implements BirdRepository {}

void main() {
	group('BirdCubit', () {
		late BirdCubit birdCubit;
		late MockBirdRepository mockBirdRepository;

		setUp(() {
			mockBirdRepository = MockBirdRepository();
			birdCubit = BirdCubit(birdRepository: mockBirdRepository);
		});

		tearDown(() {
			birdCubit.close();
		});

		test('initial state is BirdInitial', () {
			expect(birdCubit.state, BirdInitial());
		});

		blocTest<BirdCubit, BirdState>(
			'emits [BirdLoading, BirdLoaded] when loadBirds is successful',
			build: () {
				when(() => mockBirdRepository.fetchBirds()).thenAnswer((_) async => [
					Bird(name: 'Sparrow', description: 'Small bird', imageUrl: 'http://example.com/sparrow.jpg'),
					Bird(name: 'Eagle', description: 'Large bird', imageUrl: 'http://example.com/eagle.jpg'),
				]);
				return birdCubit;
			},
			act: (cubit) => cubit.loadBirds(),
			expect: () => [
				BirdLoading(),
				BirdLoaded(birds: [
					Bird(name: 'Sparrow', description: 'Small bird', imageUrl: 'http://example.com/sparrow.jpg'),
					Bird(name: 'Eagle', description: 'Large bird', imageUrl: 'http://example.com/eagle.jpg'),
				]),
			],
		);

		blocTest<BirdCubit, BirdState>(
			'emits [BirdLoading, BirdError] when loadBirds fails',
			build: () {
				when(() => mockBirdRepository.fetchBirds()).thenThrow(Exception('Failed to load birds'));
				return birdCubit;
			},
			act: (cubit) => cubit.loadBirds(),
			expect: () => [
				BirdLoading(),
				BirdError(message: 'Failed to load birds'),
			],
		);
	});
}

class BirdRepository {
	Future<List<Bird>> fetchBirds() async {
		// Simulating a network call
		await Future.delayed(Duration(seconds: 1));
		return [
			Bird(name: 'Sparrow', description: 'Small bird', imageUrl: 'http://example.com/sparrow.jpg'),
			Bird(name: 'Eagle', description: 'Large bird', imageUrl: 'http://example.com/eagle.jpg'),
		];
	}
}
