import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';
import 'package:meta/meta.dart' show required;

class Header extends StatelessWidget {
  Header({
    required this.paths,
  });

  final String paths;
  @override
  Widget build(BuildContext context) {
    final arrPhotos = paths.split(",");
    return Container(
      height: 380.0,
      width: double.infinity,
      //color: Colors.red,
      child: ConstrainedBox(
        child: Swiper(
          itemCount: arrPhotos.length,
          itemBuilder: (context, index) {
            return Hero(
              tag: "key_$paths",
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  image: DecorationImage(
                    image: NetworkImage(arrPhotos[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          pagination: SwiperPagination(
            margin: EdgeInsets.only(bottom: 60.0),
          ),
        ),
        constraints: BoxConstraints.loose(
          Size(360.0, 170.0),
        ),
      ),
    );
  }
}
