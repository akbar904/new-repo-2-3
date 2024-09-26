
class Honeybird {
	final String name;
	final String description;
	final String imageUrl;

	Honeybird({
		required this.name,
		required this.description,
		required this.imageUrl,
	});

	factory Honeybird.fromJson(Map<String, dynamic> json) {
		return Honeybird(
			name: json['name'],
			description: json['description'],
			imageUrl: json['imageUrl'],
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'name': name,
			'description': description,
			'imageUrl': imageUrl,
		};
	}
}
