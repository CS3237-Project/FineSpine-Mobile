import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ScanController extends GetxController {
  RxBool _isInitialised = RxBool(false);
  late CameraController _cameraController;
  late List<CameraDescription> _cameras;

  bool get isInitialised => _isInitialised.value;
  CameraController get cameraController => _cameraController;

  Future<void> initCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(_cameras[0], ResolutionPreset.max);
    _cameraController.initialize().then((_) {
      _isInitialised.value = true;
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
}