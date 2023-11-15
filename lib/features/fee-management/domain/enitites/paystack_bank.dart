import 'package:equatable/equatable.dart';

class PayStackBankEntity extends Equatable {
  final String? name;
  final int? id;
  final String? slug;
  final String? code;

  const PayStackBankEntity({this.name, this.id, this.slug, this.code});

  PayStackBankEntity.fromJson(Map<String, dynamic> json)
      : name = json['name'] as String?,
        id = json['id'] as int?,
        code = json['code'] as String?,
        slug = json['slug'] as String?;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'id': id,
        'code': code,
        'slug': slug,
      };

  @override
  List<Object?> get props => [name, id, code, slug];
}
