// import 'dart:async';
// import 'dart:developer';

// import 'package:http_interceptor/http_interceptor.dart';

// class HttpRequestInterceptor implements InterceptorContract {
//   @override
//   FutureOr<BaseRequest> interceptRequest({required BaseRequest request}) async {
//     // Retrieve the AppUserCubit instance from the service locator
//     final appUserCubit = serviceLocator.get<AppUserCubit>();

//     // Check if the user is logged in and get the token
//     if (appUserCubit.state is AppUserLoggedIn &&
//         request.url.host == ApiConstants.hostUrl) {
//       if (await appUserCubit.checkJwtTokenValidity()) {
//         log("Intercepting request: ${request.url}");
//         final user = (appUserCubit.state as AppUserLoggedIn).user;
//         final token = user.token;
//         request.headers['Authorization'] = 'Bearer $token';
//       } else {
//         appUserCubit.logoutUser();
//       }
//     }
//     return request;
//   }

//   @override
//   FutureOr<BaseResponse> interceptResponse(
//       {required BaseResponse response}) async {
//     // Check if the response indicates an invalid token
//     log(response.reasonPhrase.toString());
//     if (response.statusCode == 401) {
//       // Logout the user
//       final appUserCubit = serviceLocator.get<AppUserCubit>();
//       appUserCubit.logoutUser();
//       log("User logged out due to invalid token.");
//     }

//     return response;
//   }

//   @override
//   FutureOr<bool> shouldInterceptRequest() {
//     return true;
//   }

//   @override
//   FutureOr<bool> shouldInterceptResponse() {
//     return true;
//   }
// }
