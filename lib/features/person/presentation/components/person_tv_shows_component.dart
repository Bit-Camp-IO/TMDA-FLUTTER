import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tmda/config/router/app_router.dart';
import 'package:tmda/core/util/assets_manager.dart';
import 'package:tmda/core/util/color_manager.dart';
import 'package:tmda/core/util/strings_manager.dart';
import 'package:tmda/core/widgets/details_poster_card.dart';
import 'package:tmda/core/widgets/section_divider.dart';
import 'package:tmda/core/widgets/section_widget.dart';
import 'package:tmda/features/person/presentation/bloc/person_cubit.dart';

class PersonTvShowsComponent extends StatelessWidget {
  const PersonTvShowsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonCubit, PersonState>(
      builder: (context, state) {
        if (state.personData.tvShows.isNotEmpty) {
          return Animate(
            effects: [FadeEffect(duration: 150.ms)],
            child: Column(
              children: [
                const SectionWidget(
                  title: StringsManager.tv,
                  color: ColorsManager.primaryColor,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 220.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.personData.tvShows.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(width: 16.w),
                          DetailsPosterCard(
                            imagePath: state.personData.tvShows[index].posterPath,
                            errorImagePath: AssetsManager.noPoster,
                            title: state.personData.tvShows[index].title,
                            rating: state.personData.tvShows[index].voteAverage,
                            onTap: () {
                              context.pushRoute(
                                TvDetailsRoute(
                                  tvShowId: state.personData.tvShows[index].id,
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Animate(
            effects: [FadeEffect(duration: 150.ms)],
            child: Column(
              children: [
                const SectionWidget(
                  title: StringsManager.tv,
                  color: ColorsManager.primaryColor,
                ),
                SizedBox(
                  height: 220.h,
                  child: Center(
                    child: Text(
                      "We couldn't find TvShows.",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
                const SectionDivider(),
              ],
            ),
          );
        }
      },
    );
  }
}
