// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReviewsModelAdapter extends TypeAdapter<ReviewsModel> {
  @override
  final int typeId = 2;

  @override
  ReviewsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReviewsModel(
      user: fields[0] as String,
      review: fields[1] as String,
      time: fields[2] as String,
      stars: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ReviewsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.review)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.stars);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
