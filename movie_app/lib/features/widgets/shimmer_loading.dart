import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:movie_app/core/constants/color_constants.dart';
import 'package:movie_app/core/constants/size_constants.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorConstants.shimmerBase,
      highlightColor: ColorConstants.shimmerHighlight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Sizes.radiusM),
        ),
      ),
    );
  }
}

class ShimmerContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;

  const ShimmerContainer({
    super.key,
    this.width,
    this.height,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
