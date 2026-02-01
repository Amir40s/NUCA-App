import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

abstract class NetworkHelper {
  Future<http.Response> get(String url, {Map headers});

  Future<http.Response> post(String url, {Map headers, body, encoding});

  Future<http.Response> patch(String url, {Map headers, body, encoding});

  Future<http.Response> delete(String url, {Map headers,body});

  Future<http.Response> put(String url, {Map headers, body, encoding});

  Future<http.Response> postMultipartData(
      String uri, List<XFile> multipartBody,
      {Map<String, String>? headers});

  Future<http.Response> postMultipartLiscenceData(
      String uri, XFile multipartBody,
      {Map<String, String>? headers});


  Future<http.Response> patchMultipartData(
      String uri, List<XFile> multipartBody,
      {Map<String, String>? headers});

  Future<http.Response> postMultipartWithBody(
      String uri,
      List<XFile> multipartBody, {
        Map<String, String>? headers,
        required String description,
        required String tags,
        required String styleId,
      });


  Future<Map> appendHeader({Map headers});

  Future<Map> appendHeaderForFile({Map headers});

  http.Response handleResponse(http.Response response);
}
