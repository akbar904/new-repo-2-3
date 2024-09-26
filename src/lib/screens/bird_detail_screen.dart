
import 'package:flutter/material.dart';
import 'package:honeybird/models/bird.dart';

class BirdDetailScreen extends StatelessWidget {
	final Bird bird;

	const BirdDetailScreen({Key? key, required this.bird}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text(bird.name),
			),
			body: Padding(
				padding: const EdgeInsets.all(16.0),
				child: Column(
					crossAxisAlignment: CrossAxisAlignment.start,
					children: [
						Text(
							bird.name,
							style: Theme.of(context).textTheme.headline4,
						),
						const SizedBox(height: 8.0),
						Text(
							bird.description,
							style: Theme.of(context).textTheme.bodyText2,
						),
						const SizedBox(height: 16.0),
						Image.network(bird.imageUrl),
					],
				),
			),
		);
	}
}
