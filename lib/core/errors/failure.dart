import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});

  factory ServerFailure.fromDio(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(errorMessage: 'Connection Timeout');
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: 'Send Timeout');
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: 'Receive Timeout');
      case DioExceptionType.badCertificate:
        return ServerFailure(errorMessage: 'Bad Certificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioError.response!.statusCode!);
      case DioExceptionType.cancel:
        return ServerFailure(errorMessage: 'Request Cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure(errorMessage: 'Connection Error');
      case DioExceptionType.unknown:
        return ServerFailure(errorMessage: 'Unknown Error');
    }
  }
  factory ServerFailure.fromResponse(int statusCode) {
    const statusMessages = {
      400: 'Invalid Code',
      401: 'Email or password invalid',
      409: 'Email already exist',
      403: 'Forbidden',
      404: 'Not Found',
      500: 'Internal Server Error',
      502: 'Bad Gateway',
      503: 'Service Unavailable',
      504: 'Gateway Timeout',
    };

    return ServerFailure(
      errorMessage: statusMessages[statusCode] ?? 'Error: $statusCode',
    );
  }
}
