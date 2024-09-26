
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

// Import the home_screen.dart file
import 'package:com.example.honeybird/screens/home_screen.dart';
import 'package:com.example.honeybird/cubits/bird_cubit.dart';
import 'package:com.example.honeybird/cubits/bird_state.dart';
import 'package:com.example.honeybird/models/bird.dart';

// Mock Cubit
class MockBirdCubit extends MockCubit<BirdState> implements BirdCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('displays a loading indicator when state is BirdLoading', (WidgetTester tester) async {
			final mockBirdCubit = MockBirdCubit();

			when(() => mockBirdCubit.state).thenReturn(BirdLoading());

			await tester.pumpWidget(
				MaterialApp(
					home: HomeScreen(),
				),
			);

			expect(find.byType(CircularProgressIndicator), findsOneWidget);
		});

		testWidgets('displays a list of birds when state is BirdLoaded', (WidgetTester tester) async {
			final mockBirdCubit = MockBirdCubit();
			final birds = [
				Bird(name: 'Sparrow', description: 'A small bird', imageUrl: 'sparrow.jpg'),
				Bird(name: 'Eagle', description: 'A large bird of prey', imageUrl: 'eagle.jpg'),
			];

			when(() => mockBirdCubit.state).thenReturn(BirdLoaded(birds));

			await tester.pumpWidget(
				MaterialApp(
					home: HomeScreen(),
				),
			);

			expect(find.text('Sparrow'), findsOneWidget);
			expect(find.text('Eagle'), findsOneWidget);
		});

		testWidgets('displays an error message when state is BirdError', (WidgetTester tester) async {
			final mockBirdCubit = MockBirdCubit();
			final errorMessage = 'Failed to load birds';

			when(() => mockBirdCubit.state).thenReturn(BirdError(errorMessage));

			await tester.pumpWidget(
				MaterialApp(
					home: HomeScreen(),
				),
			);

			expect(find.text(errorMessage), findsOneWidget);
		});
	});

	group('HomeScreen Cubit Tests', () {
		blocTest<MockBirdCubit, BirdState>(
			'emits [BirdLoading, BirdLoaded] when loadBirds is called',
			build: () => MockBirdCubit(),
			act: (cubit) => cubit.loadBirds(),
			expect: () => [BirdLoading(), isA<BirdLoaded>()],
		);
	});
}
