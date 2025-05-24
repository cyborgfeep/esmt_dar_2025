import 'package:cours_dar_2025/models/option.dart';
import 'package:cours_dar_2025/utils/constants.dart';
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
                      cardWidget(),
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
                        itemCount: 10,
                        padding: EdgeInsets.zero,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
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
                                      "Titre",
                                      style: GoogleFonts.aBeeZee(
                                        color: primaryColor,
                                      ),
                                    ),
                                    Text(
                                      "10000F",
                                      style: GoogleFonts.aBeeZee(
                                        color: primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Date",
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

  Widget cardWidget() {
    return Container(
      height: 200,
      width: 400,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.white.withValues(alpha: .3),
            BlendMode.srcIn,
          ),
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4),
              child: Image.asset(
                "assets/images/wave_logo.png",
                width: 50,
                height: 50,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 145,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    height: 128,
                    padding: EdgeInsets.only(top: 8, bottom: 4),
                    child: PrettyQrView.data(data: 'https://google.com'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt_rounded, size: 18),
                      SizedBox(width: 5),
                      Text("Scanner"),
                    ],
                  ),
                  SizedBox(height: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
