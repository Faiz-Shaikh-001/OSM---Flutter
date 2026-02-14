class EyePower {
  final double sphere;
  final double? cylinder;
  final int? axis;
  final double? add;

  EyePower({
    required this.sphere,
    this.cylinder,
    this.axis,
    this.add
  });

  @override
  String toString() => "Sphere: $sphere\nCylinder: $cylinder\nAxis: $axis\nAdd: $add";
}