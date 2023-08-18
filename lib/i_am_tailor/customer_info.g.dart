// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerInfoAdapter extends TypeAdapter<CustomerInfo> {
  @override
  final int typeId = 0;

  @override
  CustomerInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerInfo()
      ..id = fields[0] as String?
      ..name = fields[1] as String?
      ..doorCamar = fields[2] as double?
      ..doorBasan = fields[3] as double?
      ..ghadBasan = fields[4] as double?
      ..ghadDaman = fields[5] as double?
      ..doorGardan = fields[6] as double?
      ..ghadBalaTane = fields[7] as double?
      ..ghadPayinTane = fields[8] as double?
      ..karorJelo = fields[9] as double?
      ..karorPosht = fields[10] as double?
      ..doorSine = fields[11] as double?
      ..faseleSine = fields[12] as double?
      ..ghadSine = fields[13] as double?
      ..ghadSarshane = fields[14] as double?
      ..ghadAstin = fields[15] as double?
      ..doorBazo = fields[16] as double?
      ..doorMoch = fields[17] as double?
      ..doorMosht = fields[18] as double?
      ..ghadArenj = fields[19] as double?
      ..ghadSaraphone = fields[20] as double?
      ..ghadPirahan = fields[21] as double?
      ..doorRan = fields[22] as double?
      ..ghadShalvar = fields[23] as double?
      ..dampa = fields[24] as double?;
  }

  @override
  void write(BinaryWriter writer, CustomerInfo obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.doorCamar)
      ..writeByte(3)
      ..write(obj.doorBasan)
      ..writeByte(4)
      ..write(obj.ghadBasan)
      ..writeByte(5)
      ..write(obj.ghadDaman)
      ..writeByte(6)
      ..write(obj.doorGardan)
      ..writeByte(7)
      ..write(obj.ghadBalaTane)
      ..writeByte(8)
      ..write(obj.ghadPayinTane)
      ..writeByte(9)
      ..write(obj.karorJelo)
      ..writeByte(10)
      ..write(obj.karorPosht)
      ..writeByte(11)
      ..write(obj.doorSine)
      ..writeByte(12)
      ..write(obj.faseleSine)
      ..writeByte(13)
      ..write(obj.ghadSine)
      ..writeByte(14)
      ..write(obj.ghadSarshane)
      ..writeByte(15)
      ..write(obj.ghadAstin)
      ..writeByte(16)
      ..write(obj.doorBazo)
      ..writeByte(17)
      ..write(obj.doorMoch)
      ..writeByte(18)
      ..write(obj.doorMosht)
      ..writeByte(19)
      ..write(obj.ghadArenj)
      ..writeByte(20)
      ..write(obj.ghadSaraphone)
      ..writeByte(21)
      ..write(obj.ghadPirahan)
      ..writeByte(22)
      ..write(obj.doorRan)
      ..writeByte(23)
      ..write(obj.ghadShalvar)
      ..writeByte(24)
      ..write(obj.dampa);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
