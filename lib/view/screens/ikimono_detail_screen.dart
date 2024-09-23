import 'package:flutter/material.dart';
import 'package:my_ikimono_zukan/domain/ikimono.dart';
import 'package:my_ikimono_zukan/view/components/custom_sliver_appbar.dart';
import 'package:my_ikimono_zukan/view/components/custom_sliver_to_box_adapter.dart';

class IkimonoDetailScreen extends StatelessWidget {
  const IkimonoDetailScreen({required this.ikimono, super.key});

  final Ikimono ikimono;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            ikimonoUrl: ikimono.ikimonoUrl,
          ),
          CustomSliverToBoxAdapter(
            id: ikimono.id,
            name: ikimono.name,
            description: ikimono.description,
            tag: ikimono.tag,
            capturedDate: ikimono.capturedDate,
            location: ikimono.location,
            ikimonoUrl: ikimono.ikimonoUrl,
          ),
        ],
      ),
    );
  }
}
