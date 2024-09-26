
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.honeybird/main.dart';

class MockBirdCubit extends Mock implements BirdCubit {}

void main() {
	group('MyApp Widget', () {
		testWidgets('should render MyApp and display HomeScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.byType(MyApp), findsOneWidget);
			expect(find.byType(HomeScreen), findsOneWidget);
		});
	});

	group('BirdCubit', () {
		late BirdCubit birdCubit;

		setUp(() {
			birdCubit = MockBirdCubit();
		});

		blocTest<BirdCubit, BirdState>(
			'emits [BirdInitial] when created',
			build: () => birdCubit,
			expect: () => <BirdState>[BirdInitial()],
		);

		blocTest<BirdCubit, BirdState>(
			'emits [BirdLoading, BirdLoaded] when loadBirds is called and succeeds',
			build: () => birdCubit,
			act: (cubit) => cubit.loadBirds(),
			expect: () => <BirdState>[
				BirdLoading(),
				BirdLoaded(birds: [Bird(name: 'Sparrow', description: 'A small bird', imageUrl: 'url')]),
			],
			setUp: () {
				when(() => birdCubit.loadBirds()).thenAnswer((_) async {
					birdCubit.emit(BirdLoading());
					await Future.delayed(Duration(milliseconds: 100));
					birdCubit.emit(BirdLoaded(birds: [Bird(name: 'Sparrow', description: 'A small bird', imageUrl: 'url')]));
				});
			},
		);

		blocTest<BirdCubit, BirdState>(
			'emits [BirdLoading, BirdError] when loadBirds is called and fails',
			build: () => birdCubit,
			act: (cubit) => cubit.loadBirds(),
			expect: () => <BirdState>[
				BirdLoading(),
				BirdError(message: 'Failed to load birds'),
			],
			setUp: () {
				when(() => birdCubit.loadBirds()).thenAnswer((_) async {
					birdCubit.emit(BirdLoading());
					await Future.delayed(Duration(milliseconds: 100));
					birdCubit.emit(BirdError(message: 'Failed to load birds'));
				});
			},
		);
	});
}
