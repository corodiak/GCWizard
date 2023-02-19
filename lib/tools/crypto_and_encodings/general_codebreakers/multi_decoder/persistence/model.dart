import 'package:gc_wizard/utils/json_utils.dart';

List<MultiDecoderToolEntity> multiDecoderTools = [];

MultiDecoderToolEntity findMultiDecoderToolById(int id) {
  return multiDecoderTools.firstWhere((tool) => tool.id == id);
}

class MultiDecoderToolEntity {
  late int id;
  String name;
  String internalToolName;
  List<MultiDecoderToolOption> options;

  MultiDecoderToolEntity(this.name, this.internalToolName, {this.options = const []});

  Map<String, Object> toMap() => {
        'id': id,
        'name': name,
        'decoderFunctionName': internalToolName,
        'options': options.map((option) => option.toMap()).toList()
      };

  MultiDecoderToolEntity.fromJson(Map<String, dynamic> json)
      : id = jsonInt(json['id']),
        name = jsonString(json['name']),
        internalToolName = jsonString(json['decoderFunctionName']),
        options =
            List<MultiDecoderToolOption>.from(json['options'].map((option) => MultiDecoderToolOption.fromJson(option)));

  @override
  String toString() {
    return toMap().toString();
  }
}

class MultiDecoderToolOption {
  String name;
  Object? value;

  MultiDecoderToolOption(this.name, this.value);

  Map<String, Object?> toMap() => {'name': name, 'value': value};

  MultiDecoderToolOption.fromJson(Map<String, dynamic> json)
      : name = jsonString(json['name']),
        value = json['value'];

  @override
  String toString() {
    return toMap().toString();
  }
}
