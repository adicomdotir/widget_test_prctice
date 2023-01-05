class Fixture {
  final int id;
  final int homeTeamId;
  final int awayTeamId;
  int homeTeamGoal;
  int awayTeamGoal;
  final int weekId;

  Fixture(
      this.id,
      this.weekId,
      this.homeTeamId,
      this.awayTeamId,
      this.homeTeamGoal,
      this.awayTeamGoal,
      );
}
