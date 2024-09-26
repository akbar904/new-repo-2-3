
import 'package:equatable/equatable.dart';
import 'package:honeybird/models/bird.dart';

abstract class BirdState extends Equatable {
	const BirdState();

	@override
	List<Object> get props => [];
}

class BirdInitial extends BirdState {
	const BirdInitial();
}

class BirdLoading extends BirdState {
	const BirdLoading();
}

class BirdLoaded extends BirdState {
	final List<Bird> birds;

	const BirdLoaded(this.birds);

	@override
	List<Object> get props => [birds];
}

class BirdError extends BirdState {
	final String message;

	const BirdError(this.message);

	@override
	List<Object> get props => [message];
}
