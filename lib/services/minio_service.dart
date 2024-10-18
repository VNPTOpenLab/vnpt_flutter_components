import 'package:minio_new/io.dart';
import 'package:minio_new/minio.dart';
import 'package:vnpt_flutter_components/shared/file_utils.dart';

class MinIOUploadResult {
  final List<String> uploadedFiles;
  final String? errorMessage;

  MinIOUploadResult({this.errorMessage, required this.uploadedFiles});
}

class MinIOService {
  Future<MinIOUploadResult> uploadMultipleFiles(List<String> files) async {
    List<String> results = [];
    try {
      String endpoint = "";
      String accessKey = "";
      String secretKey = "";
      String bucketName = "";
      int port = 8080;
      bool useHTTPS = false;

      final minio = Minio(
          endPoint: endpoint,
          accessKey: accessKey,
          secretKey: secretKey,
          port: port,
          useSSL: useHTTPS,
          region: 'vn');

      for (var f in files) {
        await minio.fPutObject(bucketName, FileUtils.getFileNameFromPath(f), f);
        results.add(f);
      }
      return MinIOUploadResult(uploadedFiles: results);
    } on Exception catch (err) {
      return MinIOUploadResult(
          errorMessage: 'Exception: ${err.runtimeType} ${err}',
          uploadedFiles: []);
    }
  }
}

final minIOService = MinIOService();
