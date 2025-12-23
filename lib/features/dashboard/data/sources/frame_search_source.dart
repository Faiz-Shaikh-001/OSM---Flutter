import 'package:osm/features/inventory/domain/entities/frame/frame.dart';

abstract class FrameSearchSource {
  Future<List<Frame>> search(String query);
}