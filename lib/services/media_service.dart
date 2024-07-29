import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MediaService {
  final ImagePicker _pecker = ImagePicker();

  MediaService() {}

  Future<File?> getimageFormGalery() async {
    final XFile? _file = await _pecker.pickImage(source: ImageSource.gallery);
    if (_file != null) {
      return File(_file.path);
    }
    return null;
  }

  getImageFromGallery() {}

  getImageFromCamera() {}

}
