import 'package:camera_macos/camera_macos.dart';
import 'package:flutter/material.dart';
import 'package:interactive_story/src/core/utils/layout/layout.dart';
import 'package:interactive_story/src/feature/settings/widget/settings_scope.dart';

/// {@template home_screen}
/// HomeScreen is a simple screen that displays a grid of items.
/// {@endtemplate}
class HomeScreen extends StatefulWidget {
  /// {@macro home_screen}
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CameraMacOSController macOSController;
  final GlobalKey cameraKey = GlobalKey();
  late List<CameraMacOSDevice> videoDevices;
  @override
  void initState() {
    SettingsScope.of(context, listen: false).setLocale(const Locale('ru'));
    getCameraDevices();
    super.initState();
  }

  void getCameraDevices() async {
    List<CameraMacOSDevice> videoDevices =
        await CameraMacOS.instance.listDevices(
      deviceType: CameraMacOSDeviceType.video,
    );
    setState(() {
      this.videoDevices = videoDevices;
    });
  }

  @override
  Widget build(BuildContext context) {
    final windowSize = WindowSizeScope.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                const Text('Text scale'),
                Slider(
                  divisions: 8,
                  min: 0.5,
                  max: 2,
                  value: SettingsScope.textScaleOf(context).textScale,
                  onChanged: (value) {
                    SettingsScope.textScaleOf(context).setTextScale(value);
                  },
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: CameraMacOSView(
              deviceId: videoDevices[1].deviceId,
              key: cameraKey,
              fit: BoxFit.fill,
              cameraMode: CameraMacOSMode.photo,
              onCameraInizialized: (CameraMacOSController controller) {
                setState(() {
                  this.macOSController = controller;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
