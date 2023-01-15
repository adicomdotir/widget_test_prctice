import 'dart:math';

import 'package:flutter/material.dart';
import 'package:widget_test_practice/manager_game/team_name.dart';

class LeaguePage extends StatelessWidget {
  const LeaguePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('League'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            TableHeaderWidget(),
            TableCellWidget(),
            TableCellWidget(),
            TableCellWidget(),
            TableCellWidget(),
            TableCellWidget(),
            TableCellWidget(),
            TableCellWidget(),
            TableCellWidget(),
          ],
        ),
      ),
    );
  }
}

class TableCellWidget extends StatelessWidget {
  const TableCellWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String teamName = teamNameMock[Random().nextInt(teamNameMock.length)];
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          _centerTextBuild(teamName, flex: 2),
          _centerTextBuild('11'),
          _centerTextBuild('11'),
          _centerTextBuild('11'),
          _centerTextBuild('11'),
          _centerTextBuild('11'),
          _centerTextBuild('11'),
          _centerTextBuild('+11'),
          _centerTextBuild('33'),
        ],
      ),
    );
  }

  Widget _centerTextBuild(String title, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}

class TableHeaderWidget extends StatelessWidget {
  const TableHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _centerTextBuild('Team', flex: 2),
        _centerTextBuild('Game'),
        _centerTextBuild('Win'),
        _centerTextBuild('Draw'),
        _centerTextBuild('Lost'),
        _centerTextBuild('GF'),
        _centerTextBuild('GA'),
        _centerTextBuild('GD'),
        _centerTextBuild('Pts'),
      ],
    );
  }

  Widget _centerTextBuild(String title, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
