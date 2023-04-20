import 'package:flutter/material.dart';

const categoryIcons = [
  Icons.call_received_rounded,
  Icons.price_change_rounded,
  Icons.local_activity_rounded,
  Icons.trending_up_rounded,
  Icons.paid_rounded,
  Icons.call_made_rounded,
  Icons.two_wheeler_rounded,
  Icons.receipt_rounded,
  Icons.school_rounded,
  Icons.theaters_rounded,
  Icons.restaurant_rounded,
  Icons.card_giftcard_rounded,
  Icons.child_care_rounded,
  Icons.medical_services_rounded,
  Icons.house_rounded,
  Icons.pets_rounded,
  Icons.shopping_bag_rounded,
  Icons.luggage_rounded,
  Icons.star_rounded,
  Icons.request_quote_rounded,
  Icons.shopping_cart_rounded,
  Icons.local_offer_rounded,
  Icons.weekend_rounded,
  Icons.time_to_leave_rounded,
  Icons.train_rounded,
  Icons.airplane_ticket_rounded,
  Icons.airplanemode_active_rounded,
  Icons.ev_station_rounded,
  Icons.moped_rounded,
  Icons.agriculture_rounded,
  Icons.directions_boat_rounded,
  Icons.local_bar_rounded,
  Icons.local_pizza_rounded,
  Icons.lunch_dining_rounded,
  Icons.rice_bowl_rounded,
  Icons.kitchen_rounded,
  Icons.local_cafe_rounded,
  Icons.brunch_dining_rounded,
  Icons.fastfood_rounded,
  Icons.cake_rounded,
  Icons.family_restroom_rounded,
  Icons.sports_rounded,
  Icons.sports_esports_rounded,
  Icons.sports_tennis_rounded,
  Icons.sports_soccer_rounded,
  Icons.surfing_rounded,
  Icons.downhill_skiing_rounded,
  Icons.sports_golf_rounded,
  Icons.sports_hockey_rounded,
  Icons.healing_rounded,
  Icons.local_pharmacy_rounded,
  Icons.bloodtype_rounded,
  Icons.account_balance_wallet_rounded,
  Icons.account_balance_rounded,
  Icons.savings_rounded,
  Icons.apartment_rounded,
  Icons.meeting_room_rounded,
  Icons.local_shipping_rounded,
  Icons.print_rounded,
  Icons.celebration_rounded,
  Icons.home_repair_service_rounded,
  Icons.handyman_rounded,
  Icons.local_atm_rounded,
  Icons.hotel_rounded,
  Icons.cleaning_services_rounded,
  Icons.local_taxi_rounded,
  Icons.festival_rounded,
  Icons.imagesearch_roller_rounded,
  Icons.bolt_rounded,
  Icons.code_rounded,
  Icons.local_drink_rounded,
  Icons.more_horiz_rounded,
];

const shopping = [
  Icons.card_giftcard_rounded,
  Icons.shopping_bag_rounded,
  Icons.shopping_cart_rounded,
  Icons.local_offer_rounded,
  Icons.local_activity_rounded,
  Icons.weekend_rounded,
];

const travel = [
  Icons.two_wheeler_rounded,
  Icons.time_to_leave_rounded,
  Icons.train_rounded,
  Icons.airplane_ticket_rounded,
  Icons.airplanemode_active_rounded,
  Icons.ev_station_rounded,
  Icons.moped_rounded,
  Icons.agriculture_rounded,
  Icons.directions_boat_rounded,
  Icons.luggage_rounded,
];

const food = [
  Icons.restaurant_rounded,
  Icons.local_bar_rounded,
  Icons.local_pizza_rounded,
  Icons.lunch_dining_rounded,
  Icons.rice_bowl_rounded,
  Icons.kitchen_rounded,
  Icons.local_cafe_rounded,
  Icons.brunch_dining_rounded,
  Icons.fastfood_rounded,
];

const family = [
  Icons.child_care_rounded,
  Icons.cake_rounded,
  Icons.pets_rounded,
  Icons.family_restroom_rounded,
];

const entertainment = [
  Icons.theaters_rounded,
  Icons.sports_rounded,
  Icons.sports_esports_rounded,
  Icons.sports_tennis_rounded,
  Icons.sports_soccer_rounded,
  Icons.surfing_rounded,
  Icons.downhill_skiing_rounded,
  Icons.sports_golf_rounded,
  Icons.sports_hockey_rounded,
];

const medicals = [
  Icons.medical_services_rounded,
  Icons.healing_rounded,
  Icons.local_pharmacy_rounded,
  Icons.bloodtype_rounded,
];

const finance = [
  Icons.request_quote_rounded,
  Icons.trending_up_rounded,
  Icons.paid_rounded,
  Icons.price_change_rounded,
  Icons.receipt_rounded,
  Icons.account_balance_wallet_rounded,
  Icons.account_balance_rounded,
  Icons.savings_rounded,
];

const work = [
  Icons.apartment_rounded,
  Icons.meeting_room_rounded,
  Icons.local_shipping_rounded,
  Icons.print_rounded,
];

const utilities = [
  Icons.celebration_rounded,
  Icons.home_repair_service_rounded,
  Icons.handyman_rounded,
  Icons.local_atm_rounded,
  Icons.hotel_rounded,
  Icons.cleaning_services_rounded,
  Icons.local_taxi_rounded,
  Icons.festival_rounded,
  Icons.imagesearch_roller_rounded,
  Icons.bolt_rounded,
  Icons.local_drink_rounded,
];

const categoryWiseIcons = [
  CategoryIcons('Shopping', shopping),
  CategoryIcons('Travel', travel),
  CategoryIcons('Food', food),
  CategoryIcons('Family', family),
  CategoryIcons('Entertainment', entertainment),
  CategoryIcons('Medicals', medicals),
  CategoryIcons('Finance', finance),
  CategoryIcons('Work', work),
  CategoryIcons('Utilities', utilities),
];

class CategoryIcons {
  final String name;
  final List<IconData> icons;

  const CategoryIcons(this.name, this.icons);
}

const categoryColors = [
  Color(0xFF2ecc71),
  Color(0xFFf1c40f),
  Color(0xFFe74c3c),
  Color(0xFF3498db),
  Color(0xFFd9508a),
  Color(0xFFf44336),
  Color(0xFF95A57C),
  Color(0xFFD9B8A2),
  Color(0xFFBF8686),
  Color(0xFFB33050),
  Color(0xFFB388FF),
  Color(0xFFC0FF8C),
  Color(0xFFFF6600),
  Color(0xFF6A961F),
  Color(0xFFFFD08C),
  Color(0xFFB36435),
  Color(0xFF8CEAFF),
  Color(0xFFFF8C9D),
  Color(0xFFe57373),
  Color(0xFFec407a),
  Color(0xFFad1457),
  Color(0xFFab47bc),
  Color(0xFF7b1fa2),
  Color(0xFFaa00ff),
  Color(0xFF7e57c2),
  Color(0xFF651fff),
  Color(0xFF5c6bc0),
  Color(0xFF304ffe),
  Color(0xFF42a5f5),
  Color(0xFF1565c0),
  Color(0xFF0277bd),
  Color(0xFF0091ea),
  Color(0xFF4dd0e1),
  Color(0xFF0097a7),
  Color(0xFF00b8d4),
  Color(0xFF00867d),
  Color(0xFF14cba8),
  Color(0xFF66bb6a),
  Color(0xFF00c853),
  Color(0xFFaed581),
  Color(0xFF558b2f),
  Color(0xFF76ff03),
  Color(0xFFd4e157),
  Color(0xFF9e9d24),
  Color(0xFFaeea00),
  Color(0xFFf57f17),
  Color(0xFFffd600),
  Color(0xFFff8f00),
  Color(0xFFffab00),
  Color(0xFFe65100),
  Color(0xFFdd2c00),
  Color(0xFFa1887f),
  Color(0xFF6d4c41),
  Color(0xFF616161),
  Color(0xFF546e7a),
];