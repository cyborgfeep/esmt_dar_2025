class Transaction {
  String title;
  DateTime dateTime;
  int amount;
  TypeT type;

  Transaction({
    required this.title,
    required this.dateTime,
    required this.amount,
    required this.type,
  });

  static List<Transaction> transList = [
    Transaction(
      title: "Transfert",
      dateTime: DateTime.now(),
      amount: 10000,
      type: TypeT.transferE,
    ),
  ];
}

enum TypeT { paiement, transferE, transferS, retrait, depot }
