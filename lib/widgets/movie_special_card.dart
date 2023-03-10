import 'package:flutter/material.dart';
import 'package:movie/model/movie/index.dart';
import '../screens/movie_detail.dart';

class MovieSpecialCard extends StatelessWidget {
  final MovieModel data;

  const MovieSpecialCard(this.data, {super.key});

  void _onCardTap(BuildContext context) {
    // showBottomSheet(context: context, builder: ((context) => MyBottomSheet()));
    // showModalBottomSheet(
    //     context: context,
    //     isScrollControlled: true,
    //     builder: ((context) => MyBottomSheet(data)));
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => MovieDetailPage(data.id)));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.5;
    return InkWell(
      onTap: () => _onCardTap(context),
      child: Container(
        height: width * 1.5,
        width: width,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: NetworkImage(data.imgUrl), fit: BoxFit.fill),
        ),
        child: Icon(
          Icons.play_circle,
          color: Colors.grey.withOpacity(0.6),
          size: 60,
        ),
      ),
    );
  }
}
