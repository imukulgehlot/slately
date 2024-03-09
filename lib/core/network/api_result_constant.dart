/*
class APIResultConstant {
  APIResultConstant._();
  static const int responseFail = 0;
  static const int responseSuccess = 200;
  static const int authError = 401;
  static const int notFound = 404;
  static const int invalidToken = 403;
  static const int validationMessage = 422;
  static const int internelServerError = 500;
  static const int update = 426;
  static const int underMaintenance = 503;
  static const int clientOrServerError = 400;
}
*/
class APIResultConstant {
  APIResultConstant._();

  static const int error = 0;
  static const int success = 200;
  static const int userUnauthorised = 401;
  static const int userDeleted = 403;
  static const int serverError = 500;
}
