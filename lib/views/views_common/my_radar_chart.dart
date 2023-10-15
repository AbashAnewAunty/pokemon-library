import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../data_models/pokemon.dart';

class MyRadarCart extends StatelessWidget {
  const MyRadarCart({
    super.key,
    required this.pokemon,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: RadarChart(
        RadarChartData(
          dataSets: [
            RadarDataSet(
              dataEntries: [
                RadarEntry(value: pokemon.hp.toDouble()),
                RadarEntry(value: pokemon.attack.toDouble()),
                RadarEntry(value: pokemon.defense.toDouble()),
                RadarEntry(value: pokemon.specialAttack.toDouble()),
                RadarEntry(value: pokemon.specialDefense.toDouble()),
                RadarEntry(value: pokemon.speed.toDouble()),
              ],
            ),
          ],
          getTitle: (index, angle) {
            switch (index) {
              case 0:
                return RadarChartTitle(text: 'HP \n${pokemon.hp}');
              case 1:
                return RadarChartTitle(text: 'Attack \n${pokemon.attack}');
              case 2:
                return RadarChartTitle(text: 'Defense \n${pokemon.defense}');
              case 3:
                return RadarChartTitle(
                    text: 'SpecialAttack \n${pokemon.specialAttack}');
              case 4:
                return RadarChartTitle(
                    text: 'SpecialDefense \n${pokemon.specialDefense}');
              case 5:
                return RadarChartTitle(text: 'Speed \n${pokemon.speed}');
              default:
                return const RadarChartTitle(text: '');
            }
          },
          borderData: FlBorderData(show: false),
          radarBorderData: BorderSide(color: Colors.redAccent.withOpacity(0.5)),
          radarBackgroundColor: Colors.redAccent.withOpacity(0.2),
          ticksTextStyle: const TextStyle(color: Colors.black38, fontSize: 10),
          tickBorderData: BorderSide(color: Colors.redAccent.withOpacity(0.5)),
          tickCount: 2,
          gridBorderData:
              BorderSide(color: Colors.grey.withOpacity(0.3), width: 2),
        ),
      ),
    );
  }
}
