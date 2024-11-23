// ignore_for_file: unrelated_type_equality_checks

import 'package:dio/dio.dart';
import 'package:quickmart/enums/http_status.dart';

extension DioExtension on Response {
  
  bool get isOk => statusCode!.isOk;
  
  bool get isCreated => statusCode!.isCreated;
  bool get isNotCreated => !isCreated;

  bool get successfulNoContent => statusCode!.isNoContent;
  bool get failedNoContent => !successfulNoContent;

  bool get isSuccessful => statusCode!.isOk || statusCode!.isCreated || statusCode!.isNoContent;
  bool get isNotSuccessful => !isSuccessful;

  bool get isBadRequest => statusCode!.isBadRequest;
  bool get isUnauthorized => statusCode!.isUnauthorized;
  bool get isForbidden => statusCode!.isForbidden;
  bool get isNotFound => statusCode!.isNotFound;
  bool get isInternalServerError => statusCode!.isInternalServerError;
  bool get isServiceUnavailable => statusCode!.isServiceUnavailable;
  bool get isGatewayTimeout => statusCode!.isGatewayTimeout;

  bool get isClientError => statusCode!.isClientError;
  bool get isServerError => statusCode!.isServerError;
}


extension HTTPStatusExtension on int {
  bool get isOk => HttpStatus.ok == this;
  bool get isCreated => HttpStatus.created == this;
  bool get isNoContent => HttpStatus.noContent == this;
  bool get isBadRequest => HttpStatus.badRequest == this;
  bool get isUnauthorized => HttpStatus.unauthorized == this;
  bool get isForbidden => HttpStatus.forbidden == this;
  bool get isNotFound => HttpStatus.notFound == this;
  bool get isInternalServerError => HttpStatus.internalServerError == this;
  bool get isServiceUnavailable => HttpStatus.serviceUnavailable == this;
  bool get isGatewayTimeout => HttpStatus.gatewayTimeout == this;

  bool get isClientError => this >= 400 && this < 500;
  bool get isServerError => this >= 500;
}