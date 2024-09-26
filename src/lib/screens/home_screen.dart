
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:com.example.honeybird/cubits/bird_cubit.dart';
import 'package:com.example.honeybird/cubits/bird_state.dart';
import 'package:com.example.honeybird/widgets/bird_list_item.dart';
import 'package:com.example.honeybird/models/bird.dart';

class HomeScreen extends StatelessWidget {
	const HomeScreen({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Honeybird Home'),
			),
			body: BlocBuilder<BirdCubit, BirdState>(
				builder: (context, state) {
					if (state is BirdLoading) {
						return Center(
							child: CircularProgressIndicator(),
						);
					} else if (state is BirdLoaded) {
						return ListView.builder(
							itemCount: state.birds.length,
							itemBuilder: (context, index) {
								return BirdListItem(state.birds[index]);
							},
						);
					} else if (state is BirdError) {
						return Center(
							child: Text(state.message),
						);
					} else {
						return Center(
							child: Text('Unexpected state'),
						);
					}
				},
			),
		);
	}
}
