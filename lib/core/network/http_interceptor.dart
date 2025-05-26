import 'dart:async';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:vit_ap_student_app/core/constants/server_constants.dart';

class HttpRequestInterceptor implements InterceptorContract {
  @override
  FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
    if (request.url.host == ServerConstants.hostUrl) {
      log("Intercepting request: ${request.url}");
      request.headers['X-API-KEY'] = '${dotenv.env['API_KEY']}';
    }
    log("Not Intercepting request: ${request.url.host}");
    return request;
  }

  @override
  FutureOr<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    return response;
  }

  @override
  FutureOr<bool> shouldInterceptRequest() {
    return true;
  }

  @override
  FutureOr<bool> shouldInterceptResponse() {
    return true;
  }
}
