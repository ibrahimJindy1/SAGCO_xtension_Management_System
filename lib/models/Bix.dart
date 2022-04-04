class Bix {
  final int ind;
  final int buildFK;
  final String port;
  final String bix;
  final String extensions;
  final String type;
  final String lineType;

  const Bix(this.ind, this.buildFK, this.port, this.bix, this.extensions,
      this.type, this.lineType);

  Map<String, dynamic> toJson() => {
        'ind': ind.toString(),
        'buildFK': buildFK.toString(),
        'port': port,
        'bix1': bix,
        'extension': extensions,
        'type': type,
        'lineType': lineType,
      };
}
