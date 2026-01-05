enum ProductTypeToAdd { frame, lens, accessory }

extension ProductTypeToAddX on ProductTypeToAdd {
  String get label {
    switch (this) {
      case ProductTypeToAdd.frame:
        return 'Frame';
      case ProductTypeToAdd.lens:
        return 'Lens';
      case ProductTypeToAdd.accessory:
        return 'Accessory';
    }
  }
}
