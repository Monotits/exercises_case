class Exercises {
  String? name;
  String? type;
  String? muscle;
  String? equipment;
  String? difficulty;
  String? instructions;

  Exercises({
    this.name,
    this.type,
    this.muscle,
    this.equipment,
    this.difficulty,
    this.instructions,
  });

  factory Exercises.fromJson(Map<String, dynamic> json) => Exercises(
        name: json['name'] as String?,
        type: json['type'] as String?,
        muscle: json['muscle'] as String?,
        equipment: json['equipment'] as String?,
        difficulty: json['difficulty'] as String?,
        instructions: json['instructions'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'muscle': muscle,
        'equipment': equipment,
        'difficulty': difficulty,
        'instructions': instructions,
      };
}
