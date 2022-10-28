import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as img;
import 'package:finespine/mqtt/mqtt_client_manager.dart';

class ScanController extends GetxController {
  RxBool _isInitialised = RxBool(false);
  RxBool _isConnectedToMqtt = RxBool(false);
  RxBool isActivated = RxBool(false);
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
      isActivated.value = true;
      _cameraController.startImageStream((image) {
        _cameraImage = image;
        _imageCount++;
        if (_imageCount % 90 == 0) {
          _imageCount = 0;
          MqttClientManager.sendImage(_cameraImage, 'image');
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

  void disposeCamera() {
    if (_isInitialised.value == true) {
      _cameraController.stopImageStream();
      isActivated.value = false;
    }
  }

  @override
  void onInit() {
    if (_isConnectedToMqtt.value == false) {
      MqttClientManager.connect();
      _isConnectedToMqtt.value = true;
    }
    MqttClientManager.getActivationSignal();
    super.onInit();
  }

  @override
  void dispose() {
    MqttClientManager.disconnect();
    super.dispose();
  }

  void capture() {
    img.Image image = img.Image.fromBytes(
        _cameraImage.width, _cameraImage.height, _cameraImage.planes[0].bytes,
        format: img.Format.bgra);

    Uint8List jpeg = Uint8List.fromList(img.encodeJpg(image));
    _imageList.add(jpeg);
    _imageList.refresh();
  }
}
