class Spec {
  final String titel;

  Spec({
    this.titel,
  });

  factory Spec.fromJson(Map<String, dynamic> json) {
    return Spec(
      titel: json['titre'] as String,
    );
  }

  @override
  String toString() {
    return 'Trans{id: $titel}';
  }
}
