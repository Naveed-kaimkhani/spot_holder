import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.url,
    required this.height,
    required this.width,
  });

  final String? url;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageBuilder: (context, imageProvider) => 
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius:BorderRadius.all(Radius.circular(45.r)),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      progressIndicatorBuilder: (context, url, progress) => Center(
        child: CircularProgressIndicator(
          value: progress.progress,
        ),
      ),
      imageUrl: url!,
            // cacheManager: BaseCacheManager(),

    );
  }
}
