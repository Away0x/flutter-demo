import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:learnui/pages/hotel_booking/theme.dart';

import '../models/hotel_list_data.dart';

class HotelListItem extends StatelessWidget {
  const HotelListItem({
    Key? key,
    required this.hotelData,
    required this.animationController,
    required this.animation,
    this.onTap,
    this.onLike,
  }) : super(key: key);

  final HotelListData hotelData;
  final AnimationController animationController;
  final Animation<double> animation;
  final ValueChanged<HotelListData>? onTap;
  final ValueChanged<HotelListData>? onLike;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: _buildCard(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCard() {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () => onTap?.call(hotelData),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              offset: const Offset(4, 4),
              blurRadius: 16,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          child: Stack(
            children: [
              Column(
                children: [
                  AspectRatio(
                    aspectRatio: 2,
                    child: Image.asset(
                      hotelData.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color: HotelBookingTheme.buildLightTheme().backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, top: 8, bottom: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hotelData.titleTxt,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                                _buildLocation(),
                                _buildStar(),
                              ],
                            ),
                          ),
                        ),
                        _buildPrice(),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 8,
                right: 8,
                child: _buildLikeButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrice() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '\$${hotelData.perNight}',
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
          Text(
            '/per night',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLikeButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(32.0),
        ),
        onTap: () => onLike?.call(hotelData),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.favorite_border,
            color: HotelBookingTheme.buildLightTheme().primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildStar() {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        children: <Widget>[
          RatingBar(
            initialRating: hotelData.rating,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 24,
            ratingWidget: RatingWidget(
              full: Icon(
                Icons.star_rate_rounded,
                color: HotelBookingTheme.buildLightTheme().primaryColor,
              ),
              half: Icon(
                Icons.star_half_rounded,
                color: HotelBookingTheme.buildLightTheme().primaryColor,
              ),
              empty: Icon(
                Icons.star_border_rounded,
                color: HotelBookingTheme.buildLightTheme().primaryColor,
              ),
            ),
            itemPadding: EdgeInsets.zero,
            onRatingUpdate: (rating) {
              debugPrint(rating.toString());
            },
          ),
          Text(
            ' ${hotelData.reviews} Reviews',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          hotelData.subTxt,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.withOpacity(0.8),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Icon(
          FontAwesomeIcons.mapMarkerAlt,
          size: 12,
          color: HotelBookingTheme.buildLightTheme().primaryColor,
        ),
        Expanded(
          child: Text(
            '${hotelData.dist.toStringAsFixed(1)} km to city',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
        ),
      ],
    );
  }
}
