enum TypeConnection {
  Normal,
  TwoFA,
  ErrorConnection
}

enum TypePreferedSendingMethod {
  Email,
  Mobile,
  QrCode,
  No2FA,
  ErrorConnection
}

enum TypeOfUser {
  HospitalWorker,
  Patient,
  NoSelected
}
class ConnectionParameters {
  TypeConnection typeConnection;
  TypePreferedSendingMethod typePreferedSendingMethod;
  String token;
  ConnectionParameters({
    this.typeConnection,
    this.typePreferedSendingMethod,
    this.token
  });
}