abstract class BaseResponseModel {
  final String? status;
  final int? errorCode;

  BaseResponseModel({
    this.status,
    this.errorCode,
  });
}
