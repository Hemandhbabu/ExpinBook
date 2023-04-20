import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

import '../../domain/models/category.dart';
import '../../domain/models/payment.dart';

Callback callback() => Callback(
      onCreate: (database, version) async {
        await addCategories(
          (category) => database.insert('Category', category.toMap()),
        );
        await addPaymentModes(
          (payment) => database.insert('Payment', payment.toMap()),
        );
      },
    );

Future<void> addCategories(
    Future<void> Function(Category category) insert) async {
  for (int i = 0; i < incomeCategories.length; i++) {
    final category = Category(
      id: i + 1,
      name: incomeCategories[i],
      symbol: null,
      isIncome: true,
      color: incomeColors[i],
      iconIndex: i,
      description: '${incomeCategories[i]}, etc.,',
    );
    await insert(category);
  }

  for (int i = 0; i < expenseCategories.length; i++) {
    final category = Category(
      id: i + 6,
      name: expenseCategories[i],
      isIncome: false,
      symbol: null,
      color: expenseColors[i],
      iconIndex: i + 5,
      description: '${expenseCategories[i]}, etc.,',
    );
    await insert(category);
  }
}

Future<void> addPaymentModes(
    Future<void> Function(Payment payment) insert) async {
  final payment1 = Payment(
    id: 1,
    name: 'Cash',
    mode: PaymentMode.cash,
    description: 'Currency of native country',
    color: incomeColors[0],
  );
  await insert(payment1);
  final payment2 = Payment(
    id: 2,
    name: 'Card 1',
    mode: PaymentMode.card,
    description: 'Card with ending xxxx',
    color: incomeColors[1],
  );
  await insert(payment2);
}

const incomeCategories = ["Others", "Bonus", "Coupon", "Investment", "Salary"];

const expenseCategories = [
  "Others",
  "Automobiles",
  "Bills and taxes",
  "Education",
  "Entertainment",
  "Food and Dining",
  "Gifts and donations",
  "Kids",
  "Medical",
  "Rent",
  "Pets",
  "Shopping",
  "Travelling"
];

const incomeColors = [
  Color(0xFF2ecc71),
  Color(0xFFf1c40f),
  Color(0xFFe74c3c),
  Color(0xFF3498db),
  Color(0xFFd9508a),
];

const expenseColors = [
  Color(0xFFf44336),
  Color.fromRGBO(149, 165, 124, 1),
  Color.fromRGBO(217, 184, 162, 1),
  Color.fromRGBO(191, 134, 134, 1),
  Color.fromRGBO(179, 48, 80, 1),
  Color.fromRGBO(179, 136, 255, 1),
  Color.fromRGBO(192, 255, 140, 1),
  Color.fromRGBO(255, 102, 0, 1),
  Color.fromRGBO(106, 150, 31, 1),
  Color.fromRGBO(255, 208, 140, 1),
  Color.fromRGBO(179, 100, 53, 1),
  Color.fromRGBO(140, 234, 255, 1),
  Color.fromRGBO(255, 140, 157, 1),
];
