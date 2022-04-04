class Building {
  final int ind;
  final String BuildName;

  const Building(this.ind, this.BuildName);

  Map<String, dynamic> toJson() => {
        'ind': ind.toString(),
        'BuildName': BuildName,
      };
}
