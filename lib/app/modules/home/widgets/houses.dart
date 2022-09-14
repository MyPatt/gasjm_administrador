import 'package:gasjm/app/data/models/pedido_model.dart';
import 'package:gasjm/app/modules/home/home_controller.dart';
import 'package:gasjm/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gasjm/app/core/theme/app_theme.dart'; 
import 'package:gasjm/app/global_widgets/button_favorite.dart';
import 'package:gasjm/app/global_widgets/facilite.dart';
import 'package:get/get.dart';

//"https://i.pinimg.com/236x/76/48/92/764892a84ae8e6342559c7106d257f69.jpg,
//https://i.pinimg.com/236x/7a/a6/f6/7aa6f6d4966f2b61e57d64bdbca59298.jpg,
//https://i.pinimg.com/236x/3a/60/60/3a6060012698f64272c5e3ecb4baf461.jpg"

class Houses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) => SliverPadding(
        padding: EdgeInsets.only(bottom: kBottomNavigationBarHeight * 1.5),
        sliver: Obx(
          () => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(),
              //ItemHouse(house: _.houses[index]),
              childCount: 2
              //_.houses.length,
            ),
          ),
        ),
      ),
    );
  }
}

class ItemHouse extends StatelessWidget {
  const ItemHouse({
    required this.house,
  });

  final PedidoModel house;

  @override
  Widget build(BuildContext context) {
    final arrPhotos = house.idCliente.split(',');
    return GestureDetector(
      onTap: () => Get.toNamed(AppRoutes.detail, arguments: house),
      child: Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20.0,
          right: 20.0,
        ),
        child: Hero(
          tag: "key_${house.idPedido}",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: AspectRatio(
              aspectRatio: .90,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    arrPhotos[0],
                    fit: BoxFit.fill,
                  ),
                  _Location(location: house.idEstadoPedido),
                  _DetailHouse(house: house),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Location extends StatelessWidget {
  const _Location({Key? key, required this.location}) : super(key: key);

  final String location;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 7.5,
        ),
        decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/icons/location.svg', width: 15),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                location,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(color: AppTheme.blueDark),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailHouse extends StatelessWidget {
  const _DetailHouse({required this.house});

  final PedidoModel house;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 25),
        child: Stack(
          //overflow: Overflow.visible,
          clipBehavior: Clip.none,
          children: [
            Positioned(right: 15, top: -42.5, child: ButtonFavorite()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    house.idCliente,
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: AppTheme.blueDark, fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 14,
                              backgroundImage: NetworkImage("https://i.pinimg.com/236x/76/48/92/764892a84ae8e6342559c7106d257f69.jpg,"),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Text(
                                house.idProducto,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    ?.copyWith(color: AppTheme.blueDark),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '\$${house.cantidadPedido.toStringAsFixed(0)}',
                          style: Theme.of(context).textTheme.headline5?.copyWith(
                              color: AppTheme.blueDark,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingAndReviews(
                          rating: house.cantidadPedido,
                          reviews: house.cantidadPedido,
                        ),
                        Facilities(house: house),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatingAndReviews extends StatelessWidget {
  const RatingAndReviews(
      {Key? key, required this.reviews, required this.rating})
      : super(key: key);

  final int reviews;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: List.generate(
            5,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 5),
              child: SvgPicture.asset(
                'assets/icons/star.svg',
                width: 15,
                color: (index < rating) ? AppTheme.cyan : Colors.black12,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 5),
          child: Text(
            '$reviews opinions',
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(color: Colors.black26),
          ),
        ),
      ],
    );
  }
}
