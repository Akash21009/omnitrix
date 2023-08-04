// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TagModelAdapter extends TypeAdapter<TagModel> {
  @override
  final int typeId = 2;

  @override
  TagModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TagModel(
      tasks: (fields[0] as List).cast<TaskModel>(),
      glowImage: fields[1] as String,
      borderImage: fields[2] as String,
      creatDate: fields[3] as String,
      title: fields[4] as String,
      leftTask: fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TagModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.tasks)
      ..writeByte(1)
      ..write(obj.glowImage)
      ..writeByte(2)
      ..write(obj.borderImage)
      ..writeByte(3)
      ..write(obj.creatDate)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.leftTask);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TagModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
