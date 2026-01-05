import 'package:osm/core/either.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame_type.dart';
import 'package:osm/features/inventory/domain/failures/frames/frame_failure.dart';
import 'package:osm/features/inventory/domain/success/frames/frame_success.dart';

abstract class FrameRepository {
  
  Future<Either<FrameFailure, Frame>> getById(FrameId id);

  
  Future<Either<FrameFailure, List<Frame>>> getAll();

  
  Future<Either<FrameFailure, List<Frame>>> getByCompany(
    String companyName,
  );

  Future<Either<FrameFailure, List<Frame>>> getByName(
    String name,
  );

  Future<Either<FrameFailure, List<Frame>>> getByType(
    FrameType type,
  );

  Future<Frame?> getByQrKey(
    String qrKey,
  );
  
  Future<Either<FrameFailure, FrameCreatedSuccess>> create(
    Frame frame,
  );

  Future<Either<FrameFailure, FrameUpdatedSuccess>> update(
    Frame frame,
  );

  Future<Either<FrameFailure, FrameDeletedSuccess>> delete(
    FrameId id,
  );
}
