import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image/image.dart' as img;

class ScanController extends GetxController {
  RxBool _isInitialised = RxBool(false);
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;
  late CameraImage _cameraImage;
  final RxList<Uint8List> _imageList = RxList([]);
  int _imageCount = 0;

  List<Uint8List> get imageList => _imageList;
  bool get isInitialised => _isInitialised.value;
  CameraController get cameraController => _cameraController;

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.high);
    _cameraController.initialize().then((_) {
      _isInitialised.value = true;
      _cameraController.startImageStream((image) {
        _cameraImage = image;
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
    img.Image image = img.Image.fromBytes(
        _cameraImage.width, _cameraImage.height, _cameraImage.planes[0].bytes,
        format: img.Format.bgra);

    Uint8List jpeg = Uint8List.fromList(img.encodeJpg(image));
    _imageList.add(jpeg);
    _imageList.refresh();
  }
}
