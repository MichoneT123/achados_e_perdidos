import 'package:perdidos_e_achados/models/item.dart';

class RoleDTO {
  RoleDTO({
    required this.id,
    required this.authority,
  });

  final int? id;
  final String? authority;

  factory RoleDTO.fromJson(Map<String, dynamic> json) {
    return RoleDTO(
      id: json["id"],
      authority: json["authority"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "authority": authority,
  };

  @override
  String toString() {
    return "$id, $authority";
  }
}