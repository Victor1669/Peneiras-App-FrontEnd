import 'package:peneiras/models/requests/serializable.dart';

class UserResponse {
  UserResponse();

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse();
  }
}

class CadastroEnderecoRequest extends Serializable {
  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}

class CadastroEnderecoResponse {
  CadastroEnderecoResponse();

  factory CadastroEnderecoResponse.fromJson(Map<String, dynamic> json) {
    return CadastroEnderecoResponse();
  }
}
