class PeneiraModel {
  final String titulo;
  final String clube;
  final String local;
  final String vagas;
  final String distancia;
  final String data;
  final String logoAsset;
  final bool isNovo;

  const PeneiraModel({
    required this.titulo,
    required this.clube,
    required this.local,
    required this.vagas,
    required this.distancia,
    required this.data,
    required this.logoAsset,
    this.isNovo = true,
  });
}
