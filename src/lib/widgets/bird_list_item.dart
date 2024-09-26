
import 'package:flutter/material.dart';
import 'package:honeybird/models/bird.dart';

class BirdListItem extends StatelessWidget {
	final Bird bird;

	const BirdListItem(this.bird, {Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return ListTile(
			leading: Image.network(bird.imageUrl, fit: BoxFit.cover),
			title: Text(bird.name),
			subtitle: Text(bird.description),
		);
	}
}
