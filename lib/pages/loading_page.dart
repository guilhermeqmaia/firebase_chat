import 'package:fire_base_chat/widgets/skeleton.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: double.maxFinite,
          child: ListView.builder(
            itemCount: 15,
            itemBuilder: (ctx, _) {
              return const _RowSkeleton();
            },
          ),
        ),
      ),
    );
  }
}

class _RowSkeleton extends StatelessWidget {
  const _RowSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Skeleton(
            child: CircleAvatar(
              radius: 35,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton(
                child: Container(
                  width: screenWidth * 0.6,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Skeleton(
                child: Container(
                  width: screenWidth * 0.4,
                  height: 15,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5),
              Skeleton(
                child: Container(
                  width: screenWidth * 0.25,
                  height: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
