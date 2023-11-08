import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tmda/config/router/app_router.dart';
import 'package:tmda/core/util/assets_manager.dart';
import 'package:tmda/core/util/enums.dart';
import 'package:tmda/core/widgets/neon_light_background.dart';
import 'package:tmda/features/account/presentation/components/account/movies_watchlist_component.dart';
import 'package:tmda/features/account/presentation/components/account/profile_component.dart';
import 'package:tmda/features/account/presentation/components/account/tv_show_watchlist_component.dart';
import 'package:tmda/core/widgets/no_connection.dart';
import 'package:tmda/features/shared/presentation/blocs/account_cubit/account_bloc.dart';
@RoutePage()
class AccountScreen extends StatefulWidget{
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();

}

class _AccountScreenState extends State<AccountScreen> with AutoRouteAwareStateMixin<AccountScreen>{
  TabsRouter? _tabsRouter;

  @override
  void didChangeDependencies() {
    _tabsRouter = context.tabsRouter;
    _tabsRouter?.addListener(_tabListener);
    super.didChangeDependencies();
  }

  void _tabListener(){
    if (context.tabsRouter.activeIndex == 3) {
      context.read<AccountCubit>()
        ..getAccountMoviesWatchList()
        ..getAccountTvShowsWatchList();
    }
  }

  @override
  void didPopNext() {
    context.read<AccountCubit>()
      ..getAccountMoviesWatchList()
      ..getAccountTvShowsWatchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NeonLightBackGround(
        child: BlocConsumer<AccountCubit, AccountState>(
          listener: (context, state) {
            if (state.userAccountState == UserAccountState.loggedOut) {
              context.replaceRoute(const AuthRoute());
            }
          },
          builder: (context, state) {
            switch (state.accountTabState) {
              case BlocState.initial || BlocState.loading:
                return Center(
                  child: Lottie.asset(AssetsManager.neonLoading),
                );
              case BlocState.success:
                return ListView(
                  children: [
                    SizedBox(height: 40.h),
                    const ProfileComponent(),
                    SizedBox(height: 10.h),
                    const MoviesWatchListComponent(),
                    const TvShowWatchListComponent(),
                  ],
                );
              case BlocState.failure:
                return NoConnection(
                  onTap: () {
                    context.read<AccountCubit>()
                      ..getAccountDetails()
                      ..getAccountMoviesWatchList()
                      ..getAccountTvShowsWatchList();
                  },
                );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tabsRouter?.removeListener(_tabListener);
  }
}
