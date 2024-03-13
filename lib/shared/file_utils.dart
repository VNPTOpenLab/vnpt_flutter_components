class FileUtils {
  static String getFileNameFromPath(String path, {String delimiter = "/"}) {
    List<String> parts = path.split(delimiter);
    return parts.last;
  }
}