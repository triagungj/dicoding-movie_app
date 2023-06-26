import 'package:components/app_drawer/cubit/drawer_cubit.dart';
import 'package:core/named_routes.dart';
import 'package:dependencies/flutter_bloc/flutter_bloc.dart';
import 'package:dependencies/provider/provider.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<DrawerCubit, int>(
        builder: (context, state) {
          return Column(
            children: [
              const UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/circle-g.png'),
                ),
                accountName: Text('Ditonton'),
                accountEmail: Text('ditonton@dicoding.com'),
              ),
              ListTile(
                leading: const Icon(Icons.movie),
                title: const Text('Movies'),
                selected: state == 0,
                selectedColor: Theme.of(context).colorScheme.onPrimary,
                selectedTileColor: Theme.of(context).colorScheme.primary,
                onTap: () {
                  Navigator.pop(context);
                  if (state != 0) {
                    Provider.of<DrawerCubit>(context, listen: false)
                        .setIndex(0);
                    Navigator.pushReplacementNamed(
                      context,
                      NamedRoutes.moviePage,
                    );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.tv),
                title: const Text('TV Series'),
                selected: state == 1,
                selectedColor: Theme.of(context).colorScheme.onPrimary,
                selectedTileColor: Theme.of(context).colorScheme.primary,
                onTap: () {
                  Navigator.pop(context);
                  if (state != 1) {
                    Provider.of<DrawerCubit>(context, listen: false)
                        .setIndex(1);
                    Navigator.pushReplacementNamed(
                      context,
                      NamedRoutes.tvSeriesPage,
                    );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.save_alt),
                title: const Text('Watchlist'),
                selected: state == 2,
                selectedColor: Theme.of(context).colorScheme.onPrimary,
                selectedTileColor: Theme.of(context).colorScheme.primary,
                onTap: () {
                  Navigator.pop(context);
                  if (state != 2) {
                    Provider.of<DrawerCubit>(context, listen: false)
                        .setIndex(2);
                    Navigator.pushReplacementNamed(
                      context,
                      NamedRoutes.watchlistPage,
                    );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('About'),
                selected: state == 3,
                selectedColor: Theme.of(context).colorScheme.onPrimary,
                selectedTileColor: Theme.of(context).colorScheme.primary,
                onTap: () {
                  Navigator.pop(context);
                  if (state != 3) {
                    Provider.of<DrawerCubit>(context, listen: false)
                        .setIndex(3);
                    Navigator.pushReplacementNamed(
                      context,
                      NamedRoutes.aboutPage,
                    );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
