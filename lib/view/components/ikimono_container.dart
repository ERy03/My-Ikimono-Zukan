import 'package:flutter/material.dart';
import 'package:my_ikimono_zukan/domain/ikimono.dart';
import 'package:my_ikimono_zukan/view/screens/ikimono_detail_screen.dart';

class IkimonoContainer extends StatelessWidget {
  const IkimonoContainer({required this.ikimono, super.key});

  final Ikimono ikimono;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder: (context) => IkimonoDetailScreen(ikimono: ikimono),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    ikimono.ikimonoUrl,
                  ),
                ),
              ),
            ),
          ),
          Text(
            ikimono.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
