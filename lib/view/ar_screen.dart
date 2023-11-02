import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math_64.dart' as VectorMath;

class ArScreen extends StatefulWidget {
  final List<String> fileNameList;
  const ArScreen({Key? key, required this.fileNameList}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  ArScreenState createState() => ArScreenState();
}

class ArScreenState extends State<ArScreen> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  //String localObjectReference;
  // ARNode? localObjectNode;
  //String webObjectReference;
  // ARNode? webObjectNode;
  ARNode? fileSystemNode;
  // HttpClient? httpClient;
  late String selectedValue;

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.fileNameList.isNotEmpty) {
      selectedValue = widget.fileNameList[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white.withOpacity(0.3),
        title: const Text('AR'),
        actions: [
          DropdownButton(
            underline: Container(),
            value: selectedValue,
            items: widget.fileNameList.map((String list) {
              return DropdownMenuItem(
                value: list,
                child: Text(list),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                selectedValue = value!;
              });
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: onFileSystemObjectAtOriginButtonPressed,
          backgroundColor: Colors.white,
          label: const Text("add & remove"),
          icon: const Icon(Icons.add)),
      body: ARView(
        onARViewCreated: onARViewCreated,
        planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
      ),
    );
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          customPlaneTexturePath: "Images/triangle.png",
          showWorldOrigin: true,
          handleTaps: false,
        );
    this.arObjectManager!.onInitialize();
  }

  Future<void> onFileSystemObjectAtOriginButtonPressed() async {
    if (fileSystemNode != null) {
      arObjectManager!.removeNode(fileSystemNode!);
      fileSystemNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.fileSystemAppFolderGLB,
          uri: selectedValue,
          scale: VectorMath.Vector3(0.1, 0.1, 0.1),
          position: VectorMath.Vector3(0.0, 0.0, 0.0),
          rotation: VectorMath.Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddFileSystemNode = await arObjectManager!.addNode(newNode);
      fileSystemNode = (didAddFileSystemNode!) ? newNode : null;
    }
  }
}
