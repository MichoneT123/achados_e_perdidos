class UsuarioDto {
  UsuarioDto({
     this.id,
    required this.primeiroNome,
    required this.email,
    required this.segundoNome,
    required this.telefone,
    this.roleDto,
     this.foto,
     this.estadoDaConta,
    this.password

  });

  final int? id;
  final String? primeiroNome;
  final String? email;
  final String? segundoNome;
  final String? telefone;
  final RoleDto? roleDto;
  final String? foto;
  final bool? estadoDaConta;
  final String? password;

  factory UsuarioDto.fromJson(Map<String, dynamic> json){
    return UsuarioDto(
      id: json["id"],
      primeiroNome: json["primeiroNome"],
      email: json["email"],
      segundoNome: json["segundoNome"],
      telefone: json["telefone"],
      roleDto: json["roleDTO"] == null ? null : RoleDto.fromJson(json["roleDTO"]),
      foto: json["foto"],
      estadoDaConta: json["estado_da_conta"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "primeiroNome": primeiroNome,
    "email": email,
    "segundoNome": segundoNome,
    "telefone": telefone,
    "roleDTO": roleDto?.toJson(),
    "foto": foto,
    "estado_da_conta": estadoDaConta,
    "password": password
  };

  @override
  String toString(){
    return "$id, $primeiroNome, $email, $segundoNome, $telefone, $roleDto, $foto, $estadoDaConta, ";
  }
}

class RoleDto {
  RoleDto({
    required this.id,
    required this.authority,
  });

  final int? id;
  final String? authority;

  factory RoleDto.fromJson(Map<String, dynamic> json){
    return RoleDto(
      id: json["id"],
      authority: json["authority"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "authority": authority,
  };

  @override
  String toString(){
    return "$id, $authority, ";
  }
}
