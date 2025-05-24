import 'package:camera/camera.dart';
import 'package:cours_dar_2025/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../main.dart';

class ScanScreen extends StatefulWidget {
  final String? title;

  const ScanScreen({super.key, this.title});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController controller;
  late PageController pageController;
  bool isFlashOn = false;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0);
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller
        .initialize()
        .then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        })
        .catchError((Object e) {
          if (e is CameraException) {
            switch (e.code) {
              case 'CameraAccessDenied':
                // Handle access errors here.
                break;
              default:
                // Handle other errors here.
                break;
            }
          }
        });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              Stack(
                children: [
                  Center(
                    child: AspectRatio(
                      aspectRatio: MediaQuery.of(context).size.aspectRatio,
                      child: CameraPreview(controller),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(Icons.clear, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            isFlashOn ? Icons.flash_off : Icons.flash_on,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              isFlashOn = !isFlashOn;
                            });
                            controller.setFlashMode(
                              isFlashOn ? FlashMode.torch : FlashMode.off,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.white,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: CardWidget(
                    width: 500,
                    height: 300,
                    iconSize: 70,
                    showText: false,
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ToggleSwitch(
                minWidth: 140.0,
                cornerRadius: 20.0,
                activeBgColors: [
                  [Colors.grey],
                  [Colors.white],
                ],
                activeFgColor: pageIndex == 0 ? Colors.white : Colors.black,
                inactiveBgColor: pageIndex == 0 ? Colors.black : Colors.grey,
                inactiveFgColor: pageIndex == 0 ? Colors.white : Colors.black,
                initialLabelIndex: pageIndex,
                totalSwitches: 2,
                labels: ['Scanner un code', 'Ma carte'],
                radiusStyle: true,
                onToggle: (index) {
                  setState(() {
                    pageIndex = index!;
                  });
                  pageController.jumpToPage(index!);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
