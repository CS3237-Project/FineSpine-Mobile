import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:finespine/mqtt/mqtt_client_manager.dart';

class ScanController extends GetxController {
  RxBool _isInitialised = RxBool(false);
  RxBool _isConnectedToMqtt = RxBool(false);
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  late CameraImage _cameraImage;
  final RxList<Uint8List> _imageList = RxList([]);
  int _imageCount = 0;

  List<Uint8List> get imageList => _imageList;
  bool get isInitialised => _isInitialised.value;
  bool get isConnectedToMqtt => _isConnectedToMqtt.value;
  CameraController get cameraController => _cameraController;

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.high);
    _cameraController.initialize().then((_) {
      _isInitialised.value = true;
      _cameraController.startImageStream((image) {
        _cameraImage = image;
        _imageCount++;
        if (_imageCount % 30 == 0) {
          _imageCount = 0;
          // TODO sendToMqttForClassification(image)
        }
      });
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void onInit() {
    initCamera();
    super.onInit();
  }

  void capture() {
    if (_isConnectedToMqtt.value == false) {
      MqttClientManager.connect();
      _isConnectedToMqtt.value = true;
    }
    img.Image image = img.Image.fromBytes(
        _cameraImage.width, _cameraImage.height, _cameraImage.planes[0].bytes,
        format: img.Format.bgra);

    Uint8List jpeg = Uint8List.fromList(img.encodeJpg(image));
    _imageList.add(jpeg);
    _imageList.refresh();
  }
}
