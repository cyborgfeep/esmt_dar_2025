import 'package:cours_dar_2025/utils/constants.dart';
import 'package:flutter/material.dart';

class Option {
  String title;
  IconData icon;
  Color color;

  Option({required this.title, required this.icon, required this.color});

  static List<Option> optionList = [
    Option(title: "Transfert", icon: Icons.person, color: primaryColor),
    Option(
      title: "Paiement",
      icon: Icons.shopping_cart,
      color: Colors.orangeAccent,
    ),
    Option(
      title: "Crédit",
      icon: Icons.phone_android_outlined,
      color: Colors.blue,
    ),
    Option(title: "Banque", icon: Icons.account_balance, color: Colors.red),
    Option(
      title: "Cadeaux",
      icon: Icons.card_giftcard_rounded,
      color: Colors.green,
    ),
    Option(
      title: "Coffre",
      icon: Icons.punch_clock_outlined,
      color: Colors.pink,
    ),
    Option(
      title: "Transport",
      icon: Icons.directions_bus_filled_outlined,
      color: Colors.deepOrange,
    ),
  ];
}
