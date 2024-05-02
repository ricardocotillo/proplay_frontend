import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TilePlaceholder extends StatelessWidget {
  const TilePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 150,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  width: 100,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.teal,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
