import 'package:cours_dar_2025/models/fav_contacts.dart';
import 'package:cours_dar_2025/services/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';

class TransactionScreen extends StatefulWidget {
  final String title;

  const TransactionScreen({super.key, required this.title});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Contact> contactList = [];
  List<FavContact> favContactList = [];
  bool isLoading = false;
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    getContacts();
    getFavContacts();
  }

  getFavContacts() async {
    var databasesPath = await getDatabasesPath();
    String path = "$databasesPath/contacts.db";
    databaseHelper.open(path).then((value) {
      databaseHelper.getFavContacts().then((value) {
        favContactList = value;
        setState(() {});
      });
    });
  }

  getContacts() async {
    setState(() {
      isLoading = true;
    });
    if (await FlutterContacts.requestPermission()) {
      contactList = await FlutterContacts.getContacts(withProperties: true);
      contactList.removeWhere((element) => element.phones.isEmpty);
      contactList.removeWhere(
        (element) => !element.phones.first.normalizedNumber.startsWith("+221"),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title == "Transfert"
              ? "Envoyer de l'argent"
              : "Achat de crédit",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(decoration: InputDecoration(labelText: "À")),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(45),
                    ),
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.add, color: Colors.white, size: 35),
                  ),
                  SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      widget.title == "Transfert"
                          ? "Saisir un nouveau numéro"
                          : "Acheter du crédit pour un nouveau numéro",
                      //maxLines: 1,
                      //overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.aBeeZee(fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              favContactList.isNotEmpty
                  ? Column(
                    children: [
                      Text(
                        "Favoris",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  )
                  : SizedBox.shrink(),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: favContactList.length,
                itemBuilder: (context, index) {
                  FavContact fc = favContactList[index];
                  return GestureDetector(
                    onDoubleTap: () {
                      databaseHelper.delete(fc.id!).then((value) {
                        setState(() {
                          getFavContacts();
                        });
                      });
                    },
                    child: contactWidget(name: fc.name!, phone: fc.phone!),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                "Contacts",
                style: GoogleFonts.aBeeZee(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount:
                        contactList.length > 50 ? 50 : contactList.length,
                    itemBuilder: (context, index) {
                      Contact c = contactList[index];
                      String number = c.phones.first.normalizedNumber
                          .replaceAll("+221", "");

                      return GestureDetector(
                        onDoubleTap: () {
                          FavContact fc = FavContact(
                            name: c.displayName,
                            phone: number,
                          );
                          databaseHelper.insert(fc).then((value) {
                            setState(() {
                              getFavContacts();
                            });
                          });
                        },
                        child: contactWidget(
                          name: c.displayName,
                          phone: number,
                        ),
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget contactWidget({required String name, required String phone}) {
    Color color =
        phone.startsWith("77") || phone.startsWith("78")
            ? Colors.orange
            : phone.startsWith("76")
            ? Colors.blue.shade900
            : Colors.grey;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          widget.title == "Transfert"
              ? Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Icon(Icons.person, color: Colors.grey),
              )
              : Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: color,
                ),
              ),
          SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  phone,
                  style: GoogleFonts.aBeeZee(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
