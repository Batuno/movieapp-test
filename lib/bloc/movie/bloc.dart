import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/bloc/movie/events.dart';
import 'package:movie/bloc/movie/states.dart';
import 'package:movie/global_keys.dart';
import 'package:movie/model/movie/index.dart';
import 'package:movie/services/api/index.dart';
import 'package:provider/provider.dart';

import '../../providers/common.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(const MovieInitial()) {
    on<MovieGetAll>(
      (event, emit) async {
        if (Provider.of<CommonProvider>(GlobalKeys.navigatorKey.currentContext!,
                listen: false)
            .movies
            .isEmpty) {
          emit(const MovieLoading());
          try {
            final api = ApiService();
            final res = await api.getRequest("63f5a780c0e7653a057c3513", true);
            // print(res.data);
            List<MovieModel> data = MovieModel.fromList(res.data['record']);
            Provider.of<CommonProvider>(GlobalKeys.navigatorKey.currentContext!,
                    listen: false)
                .setMovies(data);
            emit(const MovieSuccess());
          } catch (ex) {
            print(ex);
            emit(MovieFail(ex.toString()));
          }
        }
      },
    );

    on<MovieGetInfo>((event, emit) async {
      emit(const MovieLoading());
      try {
        final api = ApiService();
        final res = await api.getRequest("63f5c4d2c0e7653a057c444d", true);
        // print(res.data);
        MovieModel data = MovieModel.fromJson(res.data['record']);
        emit(MovieSuccessDetail(data));
      } catch (ex) {
        print(ex);
        emit(MovieFail(ex.toString()));
      }
    });
  }
}
