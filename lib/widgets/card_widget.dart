import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class CardWidget extends StatefulWidget {
  final double? width;
  final double? height;
  final double? iconSize;
  final bool? showText;

  const CardWidget({
    super.key,
    this.width,
    this.height,
    this.iconSize,
    this.showText = true,
  });

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: widget.height ?? 200,
        width: widget.width ?? 400,
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
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 4,
                ),
                child: Image.asset(
                  "assets/images/wave_logo.png",
                  width: widget.iconSize ?? 50,
                  height: widget.iconSize ?? 50,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 128,
                      padding: EdgeInsets.only(top: 8, bottom: 4),
                      child: PrettyQrView.data(data: 'https://google.com'),
                    ),
                    widget.showText!
                        ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt_rounded, size: 18),
                            SizedBox(width: 5),
                            Text("Scanner"),
                          ],
                        )
                        : SizedBox.shrink(),
                    SizedBox(height: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
