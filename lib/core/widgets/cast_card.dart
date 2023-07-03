import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmda/core/widgets/tilted_image_with_shadow.dart';

class CastCard extends StatelessWidget {
  const CastCard({
    super.key,
    required this.actorPicPath,
    required this.actorName,
    required this.actorCharacterName,
    required this.onTap,
    required this.errorImagePath,
  });

  final String actorPicPath;
  final String actorName;
  final String actorCharacterName;
  final String errorImagePath;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          TiltedImageWithShadow(
            errorImagePath: errorImagePath,
            imagePath: actorPicPath,
            width: 130.w,
            height: 220.h,
          ),
          Positioned(
            left: 5,
            right: 20,
            bottom: 30,
            child: Text(
              actorName,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Positioned(
            left: 5,
            right: 15,
            bottom: 15,
            child: Text(
              actorCharacterName,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          )
        ],
      ),
    );
  }
}
