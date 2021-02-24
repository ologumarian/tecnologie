import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class FilePickerHelper {
  static List<String> _paths = [];
  static FilePickerResult _result;

  // ignore: missing_return
  static Future<List<String>> openFileExplorer() async {
    try {
      _result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['doc', 'pdf', 'docx'],
      );

      if (_result != null) {
        Iterator<PlatformFile> _platformFiles = _result.files.iterator;
        while (_platformFiles.moveNext()) {
          //salvataggio path nella lista
          _paths.add(_platformFiles.current.path);
          print("FILE SEELEZIONATO");
          print("Nome File: " + _platformFiles.current.name);
          print("Bytes: " + _platformFiles.current.bytes.toString());
          print("Dimensione: " + _platformFiles.current.size.toString());
          print("Estensione: " + _platformFiles.current.extension);
          print("Percorso" + _platformFiles.current.path);
        }
        return _paths;
      } else {
        // L'utente annulla l'operazione
      }
    } on PlatformException catch (e) {
      print('Unsopported operation' + e.toString());
    }
  }
}
