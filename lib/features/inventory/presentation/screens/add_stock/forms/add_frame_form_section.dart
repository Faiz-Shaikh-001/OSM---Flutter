import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osm/core/value_objects/id.dart';
import 'package:osm/features/inventory/domain/entities/frame/frame.dart';
import 'package:osm/features/inventory/presentation/blocs/frames/frame_detail/frame_detail_bloc.dart';
import 'package:osm/features/inventory/presentation/blocs/frames/frame_list/frame_list_bloc.dart';
import 'package:osm/features/inventory/presentation/screens/add_stock/widget/frame_form_widget.dart';

class AddFrameFormSection extends StatefulWidget {
  final bool isEdit;
  final FrameId? frameId;

  const AddFrameFormSection({super.key, this.isEdit = false, this.frameId});

  @override
  State<AddFrameFormSection> createState() => _AddFrameFormSectionState();
}

class _AddFrameFormSectionState extends State<AddFrameFormSection> {
  Frame? _initialFrame;

  @override
  void initState() {
    super.initState();

    if (widget.isEdit && widget.frameId != null) {
      context.read<FrameDetailBloc>().add(GetFrameByIdEvent(widget.frameId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<FrameListBloc, FrameListState>(
          listener: (context, state) {
            if (state is FrameListActionSuccess) {
              Navigator.pop(context);
            }
            if (state is FrameListError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
        ),
      ],
      child: BlocBuilder<FrameDetailBloc, FrameDetailState>(
        builder: (context, state) {
          if (widget.isEdit) {
            if (state is FrameDetailLoading && _initialFrame == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is FrameDetailLoaded && _initialFrame == null) {
              _initialFrame = state.frame;
            }

            if (state is FrameDetailError) {
              return Center(child: Text(state.message));
            }
          }

          return FrameFormWidget(
            initialFrame: _initialFrame,
            isEdit: widget.isEdit,
            onCreate: (input) {
              context.read<FrameListBloc>().add(CreateFrameEvent(input));
            },
            onUpdate: (frame) {
              context.read<FrameListBloc>().add(UpdateFrameEvent(frame));
            },
          );
        },
      ),
    );
  }
}
