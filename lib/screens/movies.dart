import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/movie/bloc.dart';
import 'package:movie/bloc/movie/events.dart';
import 'package:movie/bloc/movie/states.dart';
import 'package:movie/widgets/movie_card.dart';
import 'package:movie/widgets/movie_special_card.dart';
import 'package:provider/provider.dart';

import '../providers/common.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  final _bloc = MovieBloc();
  bool _loading = false;
  bool _error = false;

  @override
  void initState() {
    super.initState();
    _bloc.add(const MovieGetAll());
  }

  // Future<List<MovieModel>> _getData() async {
  //   String res =
  //       await DefaultAssetBundle.of(context).loadString("assets/movies.json");
  //   List<MovieModel> data = MovieModel.fromList(jsonDecode(res));
  //   Provider.of<CommonProvider>(context, listen: false).setMovies(data);
  //   return data;
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MovieBloc, MovieState>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is MovieLoading) {
              setState(() {
                _loading = true;
                _error = false;
              });
            }
            if (state is MovieSuccess) {
              
              setState(() {
                _loading = false;
              });
            }
            if (state is MovieFail) {
              setState(() {
                _loading = false;
                _error = true;
              });
            }
          },
        ),
      ],
      child: Consumer<CommonProvider>(
        builder: ((context, provider, child) {
          return _loading
              ? const Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      color: Colors.blueAccent,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "top".tr(),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SingleChildScrollView(
                        padding: const EdgeInsets.only(left: 10),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            provider.specialData.length,
                            ((index) =>
                                MovieSpecialCard(provider.specialData[index])),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "all".tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Wrap(
                          spacing: 20,
                          runSpacing: 10,
                          children: List.generate(
                            provider.movies.length,
                            (index) => MovieCard(provider.movies[index]),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                );
        }),
      ),
    );
  }
}
