// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 1;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as String?,
      senderId: fields[1] as String?,
      name: fields[2] as String?,
      price: fields[3] as double?,
      sale: fields[4] as int?,
      description: fields[5] as String?,
      quantity: fields[6] as int?,
      category: fields[7] as String?,
      images: (fields[8] as List?)?.cast<String>(),
      reviews: (fields[9] as List?)?.cast<ReviewsModel>(),
      colors: (fields[10] as List?)?.cast<String>(),
      sizes: (fields[11] as List?)?.cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.senderId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.sale)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.category)
      ..writeByte(8)
      ..write(obj.images)
      ..writeByte(9)
      ..write(obj.reviews)
      ..writeByte(10)
      ..write(obj.colors)
      ..writeByte(11)
      ..write(obj.sizes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
