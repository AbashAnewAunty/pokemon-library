import '../enum.dart';

class Pokemon {
  final int id;
  final String name;
  final double heightM;
  final double weightKg;
  final String spriteUrlFrontDefault;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;
  final List<PokeType> types;

  Pokemon({
    required this.id,
    required this.name,
    required this.heightM,
    required this.weightKg,
    required this.spriteUrlFrontDefault,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
    required this.types,
  });

  Pokemon.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        heightM = json["height"] / 10,
        weightKg = json["weight"] / 10,
        spriteUrlFrontDefault = json['sprites']['front_default'],
        hp = json["stats"][0]["base_stat"],
        attack = json["stats"][1]["base_stat"],
        defense = json["stats"][2]["base_stat"],
        specialAttack = json["stats"][3]["base_stat"],
        specialDefense = json["stats"][4]["base_stat"],
        speed = json["stats"][5]["base_stat"],
        types = (json["types"] as List).map((e) {
          return PokeType.values.firstWhere((pokeTypeEnum) {
            return pokeTypeEnum.name == e["type"]["name"];
          });
        }).toList();
}
