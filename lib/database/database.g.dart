// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class DataBase extends DataClass implements Insertable<DataBase> {
  final int id;
  final String userName;
  final String age;
  final bool validate;
  DataBase(
      {@required this.id,
      @required this.userName,
      @required this.age,
      @required this.validate});
  factory DataBase.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return DataBase(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      userName: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}user_name']),
      age: stringType.mapFromDatabaseResponse(data['${effectivePrefix}age']),
      validate:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}validate']),
    );
  }
  factory DataBase.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return DataBase(
      id: serializer.fromJson<int>(json['id']),
      userName: serializer.fromJson<String>(json['userName']),
      age: serializer.fromJson<String>(json['age']),
      validate: serializer.fromJson<bool>(json['validate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userName': serializer.toJson<String>(userName),
      'age': serializer.toJson<String>(age),
      'validate': serializer.toJson<bool>(validate),
    };
  }

  @override
  DataBasesCompanion createCompanion(bool nullToAbsent) {
    return DataBasesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      userName: userName == null && nullToAbsent
          ? const Value.absent()
          : Value(userName),
      age: age == null && nullToAbsent ? const Value.absent() : Value(age),
      validate: validate == null && nullToAbsent
          ? const Value.absent()
          : Value(validate),
    );
  }

  DataBase copyWith({int id, String userName, String age, bool validate}) =>
      DataBase(
        id: id ?? this.id,
        userName: userName ?? this.userName,
        age: age ?? this.age,
        validate: validate ?? this.validate,
      );
  @override
  String toString() {
    return (StringBuffer('DataBase(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('age: $age, ')
          ..write('validate: $validate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(userName.hashCode, $mrjc(age.hashCode, validate.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is DataBase &&
          other.id == this.id &&
          other.userName == this.userName &&
          other.age == this.age &&
          other.validate == this.validate);
}

class DataBasesCompanion extends UpdateCompanion<DataBase> {
  final Value<int> id;
  final Value<String> userName;
  final Value<String> age;
  final Value<bool> validate;
  const DataBasesCompanion({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.age = const Value.absent(),
    this.validate = const Value.absent(),
  });
  DataBasesCompanion.insert({
    @required int id,
    @required String userName,
    @required String age,
    this.validate = const Value.absent(),
  })  : id = Value(id),
        userName = Value(userName),
        age = Value(age);
  DataBasesCompanion copyWith(
      {Value<int> id,
      Value<String> userName,
      Value<String> age,
      Value<bool> validate}) {
    return DataBasesCompanion(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      age: age ?? this.age,
      validate: validate ?? this.validate,
    );
  }
}

class $DataBasesTable extends DataBases
    with TableInfo<$DataBasesTable, DataBase> {
  final GeneratedDatabase _db;
  final String _alias;
  $DataBasesTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _userNameMeta = const VerificationMeta('userName');
  GeneratedTextColumn _userName;
  @override
  GeneratedTextColumn get userName => _userName ??= _constructUserName();
  GeneratedTextColumn _constructUserName() {
    return GeneratedTextColumn('user_name', $tableName, false,
        minTextLength: 1, maxTextLength: 25);
  }

  final VerificationMeta _ageMeta = const VerificationMeta('age');
  GeneratedTextColumn _age;
  @override
  GeneratedTextColumn get age => _age ??= _constructAge();
  GeneratedTextColumn _constructAge() {
    return GeneratedTextColumn('age', $tableName, false,
        minTextLength: 1, maxTextLength: 3);
  }

  final VerificationMeta _validateMeta = const VerificationMeta('validate');
  GeneratedBoolColumn _validate;
  @override
  GeneratedBoolColumn get validate => _validate ??= _constructValidate();
  GeneratedBoolColumn _constructValidate() {
    return GeneratedBoolColumn('validate', $tableName, false,
        defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [id, userName, age, validate];
  @override
  $DataBasesTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'data_bases';
  @override
  final String actualTableName = 'data_bases';
  @override
  VerificationContext validateIntegrity(DataBasesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (d.userName.present) {
      context.handle(_userNameMeta,
          userName.isAcceptableValue(d.userName.value, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (d.age.present) {
      context.handle(_ageMeta, age.isAcceptableValue(d.age.value, _ageMeta));
    } else if (isInserting) {
      context.missing(_ageMeta);
    }
    if (d.validate.present) {
      context.handle(_validateMeta,
          validate.isAcceptableValue(d.validate.value, _validateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  DataBase map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return DataBase.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(DataBasesCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.userName.present) {
      map['user_name'] = Variable<String, StringType>(d.userName.value);
    }
    if (d.age.present) {
      map['age'] = Variable<String, StringType>(d.age.value);
    }
    if (d.validate.present) {
      map['validate'] = Variable<bool, BoolType>(d.validate.value);
    }
    return map;
  }

  @override
  $DataBasesTable createAlias(String alias) {
    return $DataBasesTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $DataBasesTable _dataBases;
  $DataBasesTable get dataBases => _dataBases ??= $DataBasesTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dataBases];
}
