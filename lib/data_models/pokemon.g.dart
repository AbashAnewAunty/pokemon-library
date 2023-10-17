// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PokemonImpl _$$PokemonImplFromJson(Map<String, dynamic> json) =>
    _$PokemonImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      heightM: (json['heightM'] as num).toDouble(),
      weightKg: (json['weightKg'] as num).toDouble(),
      spriteUrlFrontDefault: json['spriteUrlFrontDefault'] as String,
      hp: json['hp'] as int,
      attack: json['attack'] as int,
      defense: json['defense'] as int,
      specialAttack: json['specialAttack'] as int,
      specialDefense: json['specialDefense'] as int,
      speed: json['speed'] as int,
      types: (json['types'] as List<dynamic>)
          .map((e) => $enumDecode(_$PokeTypeEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$$PokemonImplToJson(_$PokemonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'heightM': instance.heightM,
      'weightKg': instance.weightKg,
      'spriteUrlFrontDefault': instance.spriteUrlFrontDefault,
      'hp': instance.hp,
      'attack': instance.attack,
      'defense': instance.defense,
      'specialAttack': instance.specialAttack,
      'specialDefense': instance.specialDefense,
      'speed': instance.speed,
      'types': instance.types.map((e) => _$PokeTypeEnumMap[e]!).toList(),
    };

const _$PokeTypeEnumMap = {
  PokeType.normal: 'normal',
  PokeType.fire: 'fire',
  PokeType.water: 'water',
  PokeType.grass: 'grass',
  PokeType.electric: 'electric',
  PokeType.ice: 'ice',
  PokeType.fighting: 'fighting',
  PokeType.poison: 'poison',
  PokeType.ground: 'ground',
  PokeType.flying: 'flying',
  PokeType.psychic: 'psychic',
  PokeType.bug: 'bug',
  PokeType.rock: 'rock',
  PokeType.ghost: 'ghost',
  PokeType.dragon: 'dragon',
  PokeType.dark: 'dark',
  PokeType.steel: 'steel',
  PokeType.fairy: 'fairy',
};
