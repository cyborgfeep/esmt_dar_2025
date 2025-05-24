import 'package:cours_dar_2025/models/option.dart';
import 'package:cours_dar_2025/models/transaction.dart';
import 'package:cours_dar_2025/screens/scan_screen.dart';
import 'package:cours_dar_2025/utils/constants.dart';
import 'package:cours_dar_2025/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 110,
            pinned: true,
            backgroundColor: primaryColor,
            leading: IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                print("Settings");
              },
            ),
            actions: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.only(right: 8),
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Row(
                  children: [
                    Icon(Icons.sim_card, size: 18, color: Colors.black),
                    SizedBox(width: 2),
                    Text(
                      "4567",
                      style: GoogleFonts.inter(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isVisible ? "10.000F" : "•••••••",
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      !isVisible ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              centerTitle: true,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 2000,
              child: Stack(
                children: [
                  Container(color: primaryColor),
                  Container(
                    margin: EdgeInsets.only(top: 100),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ScanScreen();
                              },
                            ),
                            (route) => true,
                          );
                        },
                        child: CardWidget(),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        physics: ClampingScrollPhysics(),
                        itemCount: Option.optionList.length,
                        itemBuilder: (context, index) {
                          Option o = Option.optionList[index];
                          return optionWidget(
                            title: o.title,
                            icon: o.icon,
                            color: o.color,
                          );
                        },
                      ),
                      Divider(
                        thickness: 5,
                        color: Colors.grey.withValues(alpha: .3),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: Transaction.transList.length,
                        padding: EdgeInsets.zero,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          Transaction t = Transaction.transList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${t.type == TypeT.transferE
                                          ? "De "
                                          : t.type == TypeT.transferS
                                          ? "A "
                                          : ""}${t.title}",
                                      style: GoogleFonts.aBeeZee(
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "${t.type == TypeT.transferS || t.type == TypeT.paiement || t.type == TypeT.retrait ? "-" : ""}${t.amount}F",
                                      style: GoogleFonts.aBeeZee(
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  t.dateTime.toString(),
                                  style: GoogleFonts.aBeeZee(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget optionWidget({
    required Color color,
    required String title,
    required IconData icon,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: .2),
            borderRadius: BorderRadius.circular(45),
          ),
          child: Icon(icon, size: 35, color: color),
        ),
        SizedBox(height: 5),
        Text(title, style: GoogleFonts.aBeeZee(fontSize: 14)),
      ],
    );
  }
}
