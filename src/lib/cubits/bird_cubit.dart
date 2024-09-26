
import 'package:bloc/bloc.dart';
import 'package:honeybird/cubits/bird_state.dart';
import 'package:honeybird/models/bird.dart';
import 'package:honeybird/repositories/bird_repository.dart';

class BirdCubit extends Cubit<BirdState> {
	final BirdRepository birdRepository;

	BirdCubit({required this.birdRepository}) : super(BirdInitial());

	void loadBirds() async {
		try {
			emit(BirdLoading());
			final birds = await birdRepository.fetchBirds();
			emit(BirdLoaded(birds: birds));
		} catch (e) {
			emit(BirdError(message: 'Failed to load birds'));
		}
	}
}
