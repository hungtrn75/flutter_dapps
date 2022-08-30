class Monitoring {
  final String className;
  final String precipitation;
  final String oxygenProduction;
  final String ndvi;

  const Monitoring({
    required this.className,
    required this.precipitation,
    required this.oxygenProduction,
    required this.ndvi,
  });

  Monitoring copyWith({
    String? className,
    String? precipitation,
    String? oxygenProduction,
    String? ndvi,
  }) =>
      Monitoring(
        className: className ?? this.className,
        precipitation: precipitation ?? this.precipitation,
        oxygenProduction: oxygenProduction ?? this.oxygenProduction,
        ndvi: ndvi ?? this.ndvi,
      );
}
