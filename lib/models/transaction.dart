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
      title: "Modou FALL 77777777",
      dateTime: DateTime.now(),
      amount: 10000,
      type: TypeT.transferE,
    ),
    Transaction(
      title: "Canal+",
      dateTime: DateTime.now(),
      amount: 10000,
      type: TypeT.paiement,
    ),
    Transaction(
      title: "Retrait",
      dateTime: DateTime.now(),
      amount: 10000,
      type: TypeT.retrait,
    ),
    Transaction(
      title: "Depot",
      dateTime: DateTime.now(),
      amount: 10000,
      type: TypeT.depot,
    ),
    Transaction(
      title: "Mbaye Diop 780122332",
      dateTime: DateTime.now(),
      amount: 10000,
      type: TypeT.transferS,
    ),
  ];
}

enum TypeT { paiement, transferE, transferS, retrait, depot }
