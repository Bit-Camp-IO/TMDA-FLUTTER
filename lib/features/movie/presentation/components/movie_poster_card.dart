import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmda/core/icons/solar_system_icons.dart';
import 'package:tmda/core/util/color_manager.dart';
import 'package:tmda/features/movie/presentation/components/movie_poster_with_shadow.dart';

class MoviePosterCard extends StatelessWidget {
  const MoviePosterCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.releaseDate,
    required this.rating,
    required this.onTap,
    required this.genres,
    required this.language,
  });
  final String imagePath;
  final String title;
  final String releaseDate;
  final List genres;
  final dynamic rating;
  final String language;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          MoviePosterWithShadow(
            imagePath: imagePath,
            width: 160.w,
            height: 250.h,
          ),
          Positioned(
            left: 1,
            right: 20,
            bottom: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title.length > 20 ? '${title.substring(0, 20)}..' : title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 2.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      releaseDate.isEmpty
                          ? 'Unknown '
                          : '${releaseDate.substring(0, 4)} ‧ ',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 8.sp),
                    ),
                    Text(
                      genres.length < 2
                          ? '${genres[0].name} ‧ '
                          : '${genres[0].name}/${genres[1].name} ‧ ',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 8.sp),
                    ),
                    Text(language.toUpperCase(),
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 8.sp),
                    ),
                  ],
                ),
                SizedBox(height: 2.5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'TMDB $rating',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 8.sp),
                    ),
                    SizedBox(width: 8.w),
                    RatingBarIndicator(
                      rating: rating / 2,
                      unratedColor: ColorsManager.inActiveColor,
                      itemBuilder: (context, index) => const Icon(
                        SolarSystemIcons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 15,
                      direction: Axis.horizontal,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
