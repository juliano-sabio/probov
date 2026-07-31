// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LotesTable extends Lotes with TableInfo<$LotesTable, LoteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<DateTime> data = GeneratedColumn<DateTime>(
    'data',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contraparteMeta = const VerificationMeta(
    'contraparte',
  );
  @override
  late final GeneratedColumn<String> contraparte = GeneratedColumn<String>(
    'contraparte',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _obsMeta = const VerificationMeta('obs');
  @override
  late final GeneratedColumn<String> obs = GeneratedColumn<String>(
    'obs',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CriterioBase, int> criterioBase =
      GeneratedColumn<int>(
        'criterio_base',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<CriterioBase>($LotesTable.$convertercriterioBase);
  static const VerificationMeta _precoBaseCentavosMeta = const VerificationMeta(
    'precoBaseCentavos',
  );
  @override
  late final GeneratedColumn<int> precoBaseCentavos = GeneratedColumn<int>(
    'preco_base_centavos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rendimentoBpMeta = const VerificationMeta(
    'rendimentoBp',
  );
  @override
  late final GeneratedColumn<int> rendimentoBp = GeneratedColumn<int>(
    'rendimento_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5200),
  );
  static const VerificationMeta _racaPadraoMeta = const VerificationMeta(
    'racaPadrao',
  );
  @override
  late final GeneratedColumn<String> racaPadrao = GeneratedColumn<String>(
    'raca_padrao',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _criadoEmMeta = const VerificationMeta(
    'criadoEm',
  );
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
    'criado_em',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _atualizadoEmMeta = const VerificationMeta(
    'atualizadoEm',
  );
  @override
  late final GeneratedColumn<DateTime> atualizadoEm = GeneratedColumn<DateTime>(
    'atualizado_em',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nome,
    data,
    contraparte,
    obs,
    criterioBase,
    precoBaseCentavos,
    rendimentoBp,
    racaPadrao,
    criadoEm,
    atualizadoEm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lotes';
  @override
  VerificationContext validateIntegrity(
    Insertable<LoteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('contraparte')) {
      context.handle(
        _contraparteMeta,
        contraparte.isAcceptableOrUnknown(
          data['contraparte']!,
          _contraparteMeta,
        ),
      );
    }
    if (data.containsKey('obs')) {
      context.handle(
        _obsMeta,
        obs.isAcceptableOrUnknown(data['obs']!, _obsMeta),
      );
    }
    if (data.containsKey('preco_base_centavos')) {
      context.handle(
        _precoBaseCentavosMeta,
        precoBaseCentavos.isAcceptableOrUnknown(
          data['preco_base_centavos']!,
          _precoBaseCentavosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precoBaseCentavosMeta);
    }
    if (data.containsKey('rendimento_bp')) {
      context.handle(
        _rendimentoBpMeta,
        rendimentoBp.isAcceptableOrUnknown(
          data['rendimento_bp']!,
          _rendimentoBpMeta,
        ),
      );
    }
    if (data.containsKey('raca_padrao')) {
      context.handle(
        _racaPadraoMeta,
        racaPadrao.isAcceptableOrUnknown(data['raca_padrao']!, _racaPadraoMeta),
      );
    }
    if (data.containsKey('criado_em')) {
      context.handle(
        _criadoEmMeta,
        criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta),
      );
    } else if (isInserting) {
      context.missing(_criadoEmMeta);
    }
    if (data.containsKey('atualizado_em')) {
      context.handle(
        _atualizadoEmMeta,
        atualizadoEm.isAcceptableOrUnknown(
          data['atualizado_em']!,
          _atualizadoEmMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_atualizadoEmMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LoteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LoteRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nome'],
      )!,
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data'],
      )!,
      contraparte: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contraparte'],
      ),
      obs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}obs'],
      ),
      criterioBase: $LotesTable.$convertercriterioBase.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}criterio_base'],
        )!,
      ),
      precoBaseCentavos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preco_base_centavos'],
      )!,
      rendimentoBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rendimento_bp'],
      )!,
      racaPadrao: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raca_padrao'],
      ),
      criadoEm: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}criado_em'],
      )!,
      atualizadoEm: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}atualizado_em'],
      )!,
    );
  }

  @override
  $LotesTable createAlias(String alias) {
    return $LotesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CriterioBase, int, int> $convertercriterioBase =
      const EnumIndexConverter<CriterioBase>(CriterioBase.values);
}

class LoteRow extends DataClass implements Insertable<LoteRow> {
  final int id;
  final String nome;
  final DateTime data;
  final String? contraparte;
  final String? obs;
  final CriterioBase criterioBase;
  final int precoBaseCentavos;
  final int rendimentoBp;

  /// Apenas pré-preenche a raça na tela de pesagem. A precificação não faz
  /// fallback do animal para o lote.
  final String? racaPadrao;
  final DateTime criadoEm;
  final DateTime atualizadoEm;
  const LoteRow({
    required this.id,
    required this.nome,
    required this.data,
    this.contraparte,
    this.obs,
    required this.criterioBase,
    required this.precoBaseCentavos,
    required this.rendimentoBp,
    this.racaPadrao,
    required this.criadoEm,
    required this.atualizadoEm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['data'] = Variable<DateTime>(data);
    if (!nullToAbsent || contraparte != null) {
      map['contraparte'] = Variable<String>(contraparte);
    }
    if (!nullToAbsent || obs != null) {
      map['obs'] = Variable<String>(obs);
    }
    {
      map['criterio_base'] = Variable<int>(
        $LotesTable.$convertercriterioBase.toSql(criterioBase),
      );
    }
    map['preco_base_centavos'] = Variable<int>(precoBaseCentavos);
    map['rendimento_bp'] = Variable<int>(rendimentoBp);
    if (!nullToAbsent || racaPadrao != null) {
      map['raca_padrao'] = Variable<String>(racaPadrao);
    }
    map['criado_em'] = Variable<DateTime>(criadoEm);
    map['atualizado_em'] = Variable<DateTime>(atualizadoEm);
    return map;
  }

  LotesCompanion toCompanion(bool nullToAbsent) {
    return LotesCompanion(
      id: Value(id),
      nome: Value(nome),
      data: Value(data),
      contraparte: contraparte == null && nullToAbsent
          ? const Value.absent()
          : Value(contraparte),
      obs: obs == null && nullToAbsent ? const Value.absent() : Value(obs),
      criterioBase: Value(criterioBase),
      precoBaseCentavos: Value(precoBaseCentavos),
      rendimentoBp: Value(rendimentoBp),
      racaPadrao: racaPadrao == null && nullToAbsent
          ? const Value.absent()
          : Value(racaPadrao),
      criadoEm: Value(criadoEm),
      atualizadoEm: Value(atualizadoEm),
    );
  }

  factory LoteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LoteRow(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      data: serializer.fromJson<DateTime>(json['data']),
      contraparte: serializer.fromJson<String?>(json['contraparte']),
      obs: serializer.fromJson<String?>(json['obs']),
      criterioBase: $LotesTable.$convertercriterioBase.fromJson(
        serializer.fromJson<int>(json['criterioBase']),
      ),
      precoBaseCentavos: serializer.fromJson<int>(json['precoBaseCentavos']),
      rendimentoBp: serializer.fromJson<int>(json['rendimentoBp']),
      racaPadrao: serializer.fromJson<String?>(json['racaPadrao']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
      atualizadoEm: serializer.fromJson<DateTime>(json['atualizadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'data': serializer.toJson<DateTime>(data),
      'contraparte': serializer.toJson<String?>(contraparte),
      'obs': serializer.toJson<String?>(obs),
      'criterioBase': serializer.toJson<int>(
        $LotesTable.$convertercriterioBase.toJson(criterioBase),
      ),
      'precoBaseCentavos': serializer.toJson<int>(precoBaseCentavos),
      'rendimentoBp': serializer.toJson<int>(rendimentoBp),
      'racaPadrao': serializer.toJson<String?>(racaPadrao),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
      'atualizadoEm': serializer.toJson<DateTime>(atualizadoEm),
    };
  }

  LoteRow copyWith({
    int? id,
    String? nome,
    DateTime? data,
    Value<String?> contraparte = const Value.absent(),
    Value<String?> obs = const Value.absent(),
    CriterioBase? criterioBase,
    int? precoBaseCentavos,
    int? rendimentoBp,
    Value<String?> racaPadrao = const Value.absent(),
    DateTime? criadoEm,
    DateTime? atualizadoEm,
  }) => LoteRow(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    data: data ?? this.data,
    contraparte: contraparte.present ? contraparte.value : this.contraparte,
    obs: obs.present ? obs.value : this.obs,
    criterioBase: criterioBase ?? this.criterioBase,
    precoBaseCentavos: precoBaseCentavos ?? this.precoBaseCentavos,
    rendimentoBp: rendimentoBp ?? this.rendimentoBp,
    racaPadrao: racaPadrao.present ? racaPadrao.value : this.racaPadrao,
    criadoEm: criadoEm ?? this.criadoEm,
    atualizadoEm: atualizadoEm ?? this.atualizadoEm,
  );
  LoteRow copyWithCompanion(LotesCompanion data) {
    return LoteRow(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      data: data.data.present ? data.data.value : this.data,
      contraparte: data.contraparte.present
          ? data.contraparte.value
          : this.contraparte,
      obs: data.obs.present ? data.obs.value : this.obs,
      criterioBase: data.criterioBase.present
          ? data.criterioBase.value
          : this.criterioBase,
      precoBaseCentavos: data.precoBaseCentavos.present
          ? data.precoBaseCentavos.value
          : this.precoBaseCentavos,
      rendimentoBp: data.rendimentoBp.present
          ? data.rendimentoBp.value
          : this.rendimentoBp,
      racaPadrao: data.racaPadrao.present
          ? data.racaPadrao.value
          : this.racaPadrao,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
      atualizadoEm: data.atualizadoEm.present
          ? data.atualizadoEm.value
          : this.atualizadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LoteRow(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('data: $data, ')
          ..write('contraparte: $contraparte, ')
          ..write('obs: $obs, ')
          ..write('criterioBase: $criterioBase, ')
          ..write('precoBaseCentavos: $precoBaseCentavos, ')
          ..write('rendimentoBp: $rendimentoBp, ')
          ..write('racaPadrao: $racaPadrao, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nome,
    data,
    contraparte,
    obs,
    criterioBase,
    precoBaseCentavos,
    rendimentoBp,
    racaPadrao,
    criadoEm,
    atualizadoEm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoteRow &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.data == this.data &&
          other.contraparte == this.contraparte &&
          other.obs == this.obs &&
          other.criterioBase == this.criterioBase &&
          other.precoBaseCentavos == this.precoBaseCentavos &&
          other.rendimentoBp == this.rendimentoBp &&
          other.racaPadrao == this.racaPadrao &&
          other.criadoEm == this.criadoEm &&
          other.atualizadoEm == this.atualizadoEm);
}

class LotesCompanion extends UpdateCompanion<LoteRow> {
  final Value<int> id;
  final Value<String> nome;
  final Value<DateTime> data;
  final Value<String?> contraparte;
  final Value<String?> obs;
  final Value<CriterioBase> criterioBase;
  final Value<int> precoBaseCentavos;
  final Value<int> rendimentoBp;
  final Value<String?> racaPadrao;
  final Value<DateTime> criadoEm;
  final Value<DateTime> atualizadoEm;
  const LotesCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.data = const Value.absent(),
    this.contraparte = const Value.absent(),
    this.obs = const Value.absent(),
    this.criterioBase = const Value.absent(),
    this.precoBaseCentavos = const Value.absent(),
    this.rendimentoBp = const Value.absent(),
    this.racaPadrao = const Value.absent(),
    this.criadoEm = const Value.absent(),
    this.atualizadoEm = const Value.absent(),
  });
  LotesCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required DateTime data,
    this.contraparte = const Value.absent(),
    this.obs = const Value.absent(),
    required CriterioBase criterioBase,
    required int precoBaseCentavos,
    this.rendimentoBp = const Value.absent(),
    this.racaPadrao = const Value.absent(),
    required DateTime criadoEm,
    required DateTime atualizadoEm,
  }) : nome = Value(nome),
       data = Value(data),
       criterioBase = Value(criterioBase),
       precoBaseCentavos = Value(precoBaseCentavos),
       criadoEm = Value(criadoEm),
       atualizadoEm = Value(atualizadoEm);
  static Insertable<LoteRow> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<DateTime>? data,
    Expression<String>? contraparte,
    Expression<String>? obs,
    Expression<int>? criterioBase,
    Expression<int>? precoBaseCentavos,
    Expression<int>? rendimentoBp,
    Expression<String>? racaPadrao,
    Expression<DateTime>? criadoEm,
    Expression<DateTime>? atualizadoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (data != null) 'data': data,
      if (contraparte != null) 'contraparte': contraparte,
      if (obs != null) 'obs': obs,
      if (criterioBase != null) 'criterio_base': criterioBase,
      if (precoBaseCentavos != null) 'preco_base_centavos': precoBaseCentavos,
      if (rendimentoBp != null) 'rendimento_bp': rendimentoBp,
      if (racaPadrao != null) 'raca_padrao': racaPadrao,
      if (criadoEm != null) 'criado_em': criadoEm,
      if (atualizadoEm != null) 'atualizado_em': atualizadoEm,
    });
  }

  LotesCompanion copyWith({
    Value<int>? id,
    Value<String>? nome,
    Value<DateTime>? data,
    Value<String?>? contraparte,
    Value<String?>? obs,
    Value<CriterioBase>? criterioBase,
    Value<int>? precoBaseCentavos,
    Value<int>? rendimentoBp,
    Value<String?>? racaPadrao,
    Value<DateTime>? criadoEm,
    Value<DateTime>? atualizadoEm,
  }) {
    return LotesCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      data: data ?? this.data,
      contraparte: contraparte ?? this.contraparte,
      obs: obs ?? this.obs,
      criterioBase: criterioBase ?? this.criterioBase,
      precoBaseCentavos: precoBaseCentavos ?? this.precoBaseCentavos,
      rendimentoBp: rendimentoBp ?? this.rendimentoBp,
      racaPadrao: racaPadrao ?? this.racaPadrao,
      criadoEm: criadoEm ?? this.criadoEm,
      atualizadoEm: atualizadoEm ?? this.atualizadoEm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    if (contraparte.present) {
      map['contraparte'] = Variable<String>(contraparte.value);
    }
    if (obs.present) {
      map['obs'] = Variable<String>(obs.value);
    }
    if (criterioBase.present) {
      map['criterio_base'] = Variable<int>(
        $LotesTable.$convertercriterioBase.toSql(criterioBase.value),
      );
    }
    if (precoBaseCentavos.present) {
      map['preco_base_centavos'] = Variable<int>(precoBaseCentavos.value);
    }
    if (rendimentoBp.present) {
      map['rendimento_bp'] = Variable<int>(rendimentoBp.value);
    }
    if (racaPadrao.present) {
      map['raca_padrao'] = Variable<String>(racaPadrao.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    if (atualizadoEm.present) {
      map['atualizado_em'] = Variable<DateTime>(atualizadoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LotesCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('data: $data, ')
          ..write('contraparte: $contraparte, ')
          ..write('obs: $obs, ')
          ..write('criterioBase: $criterioBase, ')
          ..write('precoBaseCentavos: $precoBaseCentavos, ')
          ..write('rendimentoBp: $rendimentoBp, ')
          ..write('racaPadrao: $racaPadrao, ')
          ..write('criadoEm: $criadoEm, ')
          ..write('atualizadoEm: $atualizadoEm')
          ..write(')'))
        .toString();
  }
}

class $RegrasPrecoTable extends RegrasPreco
    with TableInfo<$RegrasPrecoTable, RegraPrecoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RegrasPrecoTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _loteIdMeta = const VerificationMeta('loteId');
  @override
  late final GeneratedColumn<int> loteId = GeneratedColumn<int>(
    'lote_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES lotes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ordemMeta = const VerificationMeta('ordem');
  @override
  late final GeneratedColumn<int> ordem = GeneratedColumn<int>(
    'ordem',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pesoMinGMeta = const VerificationMeta(
    'pesoMinG',
  );
  @override
  late final GeneratedColumn<int> pesoMinG = GeneratedColumn<int>(
    'peso_min_g',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pesoMaxGMeta = const VerificationMeta(
    'pesoMaxG',
  );
  @override
  late final GeneratedColumn<int> pesoMaxG = GeneratedColumn<int>(
    'peso_max_g',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _racaMeta = const VerificationMeta('raca');
  @override
  late final GeneratedColumn<String> raca = GeneratedColumn<String>(
    'raca',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _precoCentavosMeta = const VerificationMeta(
    'precoCentavos',
  );
  @override
  late final GeneratedColumn<int> precoCentavos = GeneratedColumn<int>(
    'preco_centavos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rendimentoBpMeta = const VerificationMeta(
    'rendimentoBp',
  );
  @override
  late final GeneratedColumn<int> rendimentoBp = GeneratedColumn<int>(
    'rendimento_bp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    loteId,
    ordem,
    pesoMinG,
    pesoMaxG,
    raca,
    precoCentavos,
    rendimentoBp,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'regras_preco';
  @override
  VerificationContext validateIntegrity(
    Insertable<RegraPrecoRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lote_id')) {
      context.handle(
        _loteIdMeta,
        loteId.isAcceptableOrUnknown(data['lote_id']!, _loteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_loteIdMeta);
    }
    if (data.containsKey('ordem')) {
      context.handle(
        _ordemMeta,
        ordem.isAcceptableOrUnknown(data['ordem']!, _ordemMeta),
      );
    } else if (isInserting) {
      context.missing(_ordemMeta);
    }
    if (data.containsKey('peso_min_g')) {
      context.handle(
        _pesoMinGMeta,
        pesoMinG.isAcceptableOrUnknown(data['peso_min_g']!, _pesoMinGMeta),
      );
    }
    if (data.containsKey('peso_max_g')) {
      context.handle(
        _pesoMaxGMeta,
        pesoMaxG.isAcceptableOrUnknown(data['peso_max_g']!, _pesoMaxGMeta),
      );
    }
    if (data.containsKey('raca')) {
      context.handle(
        _racaMeta,
        raca.isAcceptableOrUnknown(data['raca']!, _racaMeta),
      );
    }
    if (data.containsKey('preco_centavos')) {
      context.handle(
        _precoCentavosMeta,
        precoCentavos.isAcceptableOrUnknown(
          data['preco_centavos']!,
          _precoCentavosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precoCentavosMeta);
    }
    if (data.containsKey('rendimento_bp')) {
      context.handle(
        _rendimentoBpMeta,
        rendimentoBp.isAcceptableOrUnknown(
          data['rendimento_bp']!,
          _rendimentoBpMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RegraPrecoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RegraPrecoRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      loteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lote_id'],
      )!,
      ordem: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordem'],
      )!,
      pesoMinG: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}peso_min_g'],
      ),
      pesoMaxG: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}peso_max_g'],
      ),
      raca: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raca'],
      ),
      precoCentavos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preco_centavos'],
      )!,
      rendimentoBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rendimento_bp'],
      ),
    );
  }

  @override
  $RegrasPrecoTable createAlias(String alias) {
    return $RegrasPrecoTable(attachedDatabase, alias);
  }
}

class RegraPrecoRow extends DataClass implements Insertable<RegraPrecoRow> {
  final int id;
  final int loteId;
  final int ordem;
  final int? pesoMinG;
  final int? pesoMaxG;
  final String? raca;
  final int precoCentavos;
  final int? rendimentoBp;
  const RegraPrecoRow({
    required this.id,
    required this.loteId,
    required this.ordem,
    this.pesoMinG,
    this.pesoMaxG,
    this.raca,
    required this.precoCentavos,
    this.rendimentoBp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lote_id'] = Variable<int>(loteId);
    map['ordem'] = Variable<int>(ordem);
    if (!nullToAbsent || pesoMinG != null) {
      map['peso_min_g'] = Variable<int>(pesoMinG);
    }
    if (!nullToAbsent || pesoMaxG != null) {
      map['peso_max_g'] = Variable<int>(pesoMaxG);
    }
    if (!nullToAbsent || raca != null) {
      map['raca'] = Variable<String>(raca);
    }
    map['preco_centavos'] = Variable<int>(precoCentavos);
    if (!nullToAbsent || rendimentoBp != null) {
      map['rendimento_bp'] = Variable<int>(rendimentoBp);
    }
    return map;
  }

  RegrasPrecoCompanion toCompanion(bool nullToAbsent) {
    return RegrasPrecoCompanion(
      id: Value(id),
      loteId: Value(loteId),
      ordem: Value(ordem),
      pesoMinG: pesoMinG == null && nullToAbsent
          ? const Value.absent()
          : Value(pesoMinG),
      pesoMaxG: pesoMaxG == null && nullToAbsent
          ? const Value.absent()
          : Value(pesoMaxG),
      raca: raca == null && nullToAbsent ? const Value.absent() : Value(raca),
      precoCentavos: Value(precoCentavos),
      rendimentoBp: rendimentoBp == null && nullToAbsent
          ? const Value.absent()
          : Value(rendimentoBp),
    );
  }

  factory RegraPrecoRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RegraPrecoRow(
      id: serializer.fromJson<int>(json['id']),
      loteId: serializer.fromJson<int>(json['loteId']),
      ordem: serializer.fromJson<int>(json['ordem']),
      pesoMinG: serializer.fromJson<int?>(json['pesoMinG']),
      pesoMaxG: serializer.fromJson<int?>(json['pesoMaxG']),
      raca: serializer.fromJson<String?>(json['raca']),
      precoCentavos: serializer.fromJson<int>(json['precoCentavos']),
      rendimentoBp: serializer.fromJson<int?>(json['rendimentoBp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'loteId': serializer.toJson<int>(loteId),
      'ordem': serializer.toJson<int>(ordem),
      'pesoMinG': serializer.toJson<int?>(pesoMinG),
      'pesoMaxG': serializer.toJson<int?>(pesoMaxG),
      'raca': serializer.toJson<String?>(raca),
      'precoCentavos': serializer.toJson<int>(precoCentavos),
      'rendimentoBp': serializer.toJson<int?>(rendimentoBp),
    };
  }

  RegraPrecoRow copyWith({
    int? id,
    int? loteId,
    int? ordem,
    Value<int?> pesoMinG = const Value.absent(),
    Value<int?> pesoMaxG = const Value.absent(),
    Value<String?> raca = const Value.absent(),
    int? precoCentavos,
    Value<int?> rendimentoBp = const Value.absent(),
  }) => RegraPrecoRow(
    id: id ?? this.id,
    loteId: loteId ?? this.loteId,
    ordem: ordem ?? this.ordem,
    pesoMinG: pesoMinG.present ? pesoMinG.value : this.pesoMinG,
    pesoMaxG: pesoMaxG.present ? pesoMaxG.value : this.pesoMaxG,
    raca: raca.present ? raca.value : this.raca,
    precoCentavos: precoCentavos ?? this.precoCentavos,
    rendimentoBp: rendimentoBp.present ? rendimentoBp.value : this.rendimentoBp,
  );
  RegraPrecoRow copyWithCompanion(RegrasPrecoCompanion data) {
    return RegraPrecoRow(
      id: data.id.present ? data.id.value : this.id,
      loteId: data.loteId.present ? data.loteId.value : this.loteId,
      ordem: data.ordem.present ? data.ordem.value : this.ordem,
      pesoMinG: data.pesoMinG.present ? data.pesoMinG.value : this.pesoMinG,
      pesoMaxG: data.pesoMaxG.present ? data.pesoMaxG.value : this.pesoMaxG,
      raca: data.raca.present ? data.raca.value : this.raca,
      precoCentavos: data.precoCentavos.present
          ? data.precoCentavos.value
          : this.precoCentavos,
      rendimentoBp: data.rendimentoBp.present
          ? data.rendimentoBp.value
          : this.rendimentoBp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RegraPrecoRow(')
          ..write('id: $id, ')
          ..write('loteId: $loteId, ')
          ..write('ordem: $ordem, ')
          ..write('pesoMinG: $pesoMinG, ')
          ..write('pesoMaxG: $pesoMaxG, ')
          ..write('raca: $raca, ')
          ..write('precoCentavos: $precoCentavos, ')
          ..write('rendimentoBp: $rendimentoBp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    loteId,
    ordem,
    pesoMinG,
    pesoMaxG,
    raca,
    precoCentavos,
    rendimentoBp,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegraPrecoRow &&
          other.id == this.id &&
          other.loteId == this.loteId &&
          other.ordem == this.ordem &&
          other.pesoMinG == this.pesoMinG &&
          other.pesoMaxG == this.pesoMaxG &&
          other.raca == this.raca &&
          other.precoCentavos == this.precoCentavos &&
          other.rendimentoBp == this.rendimentoBp);
}

class RegrasPrecoCompanion extends UpdateCompanion<RegraPrecoRow> {
  final Value<int> id;
  final Value<int> loteId;
  final Value<int> ordem;
  final Value<int?> pesoMinG;
  final Value<int?> pesoMaxG;
  final Value<String?> raca;
  final Value<int> precoCentavos;
  final Value<int?> rendimentoBp;
  const RegrasPrecoCompanion({
    this.id = const Value.absent(),
    this.loteId = const Value.absent(),
    this.ordem = const Value.absent(),
    this.pesoMinG = const Value.absent(),
    this.pesoMaxG = const Value.absent(),
    this.raca = const Value.absent(),
    this.precoCentavos = const Value.absent(),
    this.rendimentoBp = const Value.absent(),
  });
  RegrasPrecoCompanion.insert({
    this.id = const Value.absent(),
    required int loteId,
    required int ordem,
    this.pesoMinG = const Value.absent(),
    this.pesoMaxG = const Value.absent(),
    this.raca = const Value.absent(),
    required int precoCentavos,
    this.rendimentoBp = const Value.absent(),
  }) : loteId = Value(loteId),
       ordem = Value(ordem),
       precoCentavos = Value(precoCentavos);
  static Insertable<RegraPrecoRow> custom({
    Expression<int>? id,
    Expression<int>? loteId,
    Expression<int>? ordem,
    Expression<int>? pesoMinG,
    Expression<int>? pesoMaxG,
    Expression<String>? raca,
    Expression<int>? precoCentavos,
    Expression<int>? rendimentoBp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (loteId != null) 'lote_id': loteId,
      if (ordem != null) 'ordem': ordem,
      if (pesoMinG != null) 'peso_min_g': pesoMinG,
      if (pesoMaxG != null) 'peso_max_g': pesoMaxG,
      if (raca != null) 'raca': raca,
      if (precoCentavos != null) 'preco_centavos': precoCentavos,
      if (rendimentoBp != null) 'rendimento_bp': rendimentoBp,
    });
  }

  RegrasPrecoCompanion copyWith({
    Value<int>? id,
    Value<int>? loteId,
    Value<int>? ordem,
    Value<int?>? pesoMinG,
    Value<int?>? pesoMaxG,
    Value<String?>? raca,
    Value<int>? precoCentavos,
    Value<int?>? rendimentoBp,
  }) {
    return RegrasPrecoCompanion(
      id: id ?? this.id,
      loteId: loteId ?? this.loteId,
      ordem: ordem ?? this.ordem,
      pesoMinG: pesoMinG ?? this.pesoMinG,
      pesoMaxG: pesoMaxG ?? this.pesoMaxG,
      raca: raca ?? this.raca,
      precoCentavos: precoCentavos ?? this.precoCentavos,
      rendimentoBp: rendimentoBp ?? this.rendimentoBp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (loteId.present) {
      map['lote_id'] = Variable<int>(loteId.value);
    }
    if (ordem.present) {
      map['ordem'] = Variable<int>(ordem.value);
    }
    if (pesoMinG.present) {
      map['peso_min_g'] = Variable<int>(pesoMinG.value);
    }
    if (pesoMaxG.present) {
      map['peso_max_g'] = Variable<int>(pesoMaxG.value);
    }
    if (raca.present) {
      map['raca'] = Variable<String>(raca.value);
    }
    if (precoCentavos.present) {
      map['preco_centavos'] = Variable<int>(precoCentavos.value);
    }
    if (rendimentoBp.present) {
      map['rendimento_bp'] = Variable<int>(rendimentoBp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RegrasPrecoCompanion(')
          ..write('id: $id, ')
          ..write('loteId: $loteId, ')
          ..write('ordem: $ordem, ')
          ..write('pesoMinG: $pesoMinG, ')
          ..write('pesoMaxG: $pesoMaxG, ')
          ..write('raca: $raca, ')
          ..write('precoCentavos: $precoCentavos, ')
          ..write('rendimentoBp: $rendimentoBp')
          ..write(')'))
        .toString();
  }
}

class $AnimaisTable extends Animais with TableInfo<$AnimaisTable, AnimalRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnimaisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _loteIdMeta = const VerificationMeta('loteId');
  @override
  late final GeneratedColumn<int> loteId = GeneratedColumn<int>(
    'lote_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES lotes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sequenciaMeta = const VerificationMeta(
    'sequencia',
  );
  @override
  late final GeneratedColumn<int> sequencia = GeneratedColumn<int>(
    'sequencia',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pesoGMeta = const VerificationMeta('pesoG');
  @override
  late final GeneratedColumn<int> pesoG = GeneratedColumn<int>(
    'peso_g',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brincoMeta = const VerificationMeta('brinco');
  @override
  late final GeneratedColumn<String> brinco = GeneratedColumn<String>(
    'brinco',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _racaMeta = const VerificationMeta('raca');
  @override
  late final GeneratedColumn<String> raca = GeneratedColumn<String>(
    'raca',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sexoMeta = const VerificationMeta('sexo');
  @override
  late final GeneratedColumn<String> sexo = GeneratedColumn<String>(
    'sexo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _obsMeta = const VerificationMeta('obs');
  @override
  late final GeneratedColumn<String> obs = GeneratedColumn<String>(
    'obs',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _criadoEmMeta = const VerificationMeta(
    'criadoEm',
  );
  @override
  late final GeneratedColumn<DateTime> criadoEm = GeneratedColumn<DateTime>(
    'criado_em',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    loteId,
    sequencia,
    pesoG,
    brinco,
    raca,
    sexo,
    obs,
    criadoEm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'animais';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnimalRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('lote_id')) {
      context.handle(
        _loteIdMeta,
        loteId.isAcceptableOrUnknown(data['lote_id']!, _loteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_loteIdMeta);
    }
    if (data.containsKey('sequencia')) {
      context.handle(
        _sequenciaMeta,
        sequencia.isAcceptableOrUnknown(data['sequencia']!, _sequenciaMeta),
      );
    } else if (isInserting) {
      context.missing(_sequenciaMeta);
    }
    if (data.containsKey('peso_g')) {
      context.handle(
        _pesoGMeta,
        pesoG.isAcceptableOrUnknown(data['peso_g']!, _pesoGMeta),
      );
    } else if (isInserting) {
      context.missing(_pesoGMeta);
    }
    if (data.containsKey('brinco')) {
      context.handle(
        _brincoMeta,
        brinco.isAcceptableOrUnknown(data['brinco']!, _brincoMeta),
      );
    }
    if (data.containsKey('raca')) {
      context.handle(
        _racaMeta,
        raca.isAcceptableOrUnknown(data['raca']!, _racaMeta),
      );
    }
    if (data.containsKey('sexo')) {
      context.handle(
        _sexoMeta,
        sexo.isAcceptableOrUnknown(data['sexo']!, _sexoMeta),
      );
    }
    if (data.containsKey('obs')) {
      context.handle(
        _obsMeta,
        obs.isAcceptableOrUnknown(data['obs']!, _obsMeta),
      );
    }
    if (data.containsKey('criado_em')) {
      context.handle(
        _criadoEmMeta,
        criadoEm.isAcceptableOrUnknown(data['criado_em']!, _criadoEmMeta),
      );
    } else if (isInserting) {
      context.missing(_criadoEmMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnimalRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnimalRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      loteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}lote_id'],
      )!,
      sequencia: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sequencia'],
      )!,
      pesoG: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}peso_g'],
      )!,
      brinco: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brinco'],
      ),
      raca: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}raca'],
      ),
      sexo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sexo'],
      ),
      obs: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}obs'],
      ),
      criadoEm: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}criado_em'],
      )!,
    );
  }

  @override
  $AnimaisTable createAlias(String alias) {
    return $AnimaisTable(attachedDatabase, alias);
  }
}

class AnimalRow extends DataClass implements Insertable<AnimalRow> {
  final int id;
  final int loteId;
  final int sequencia;
  final int pesoG;
  final String? brinco;
  final String? raca;
  final String? sexo;
  final String? obs;
  final DateTime criadoEm;
  const AnimalRow({
    required this.id,
    required this.loteId,
    required this.sequencia,
    required this.pesoG,
    this.brinco,
    this.raca,
    this.sexo,
    this.obs,
    required this.criadoEm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['lote_id'] = Variable<int>(loteId);
    map['sequencia'] = Variable<int>(sequencia);
    map['peso_g'] = Variable<int>(pesoG);
    if (!nullToAbsent || brinco != null) {
      map['brinco'] = Variable<String>(brinco);
    }
    if (!nullToAbsent || raca != null) {
      map['raca'] = Variable<String>(raca);
    }
    if (!nullToAbsent || sexo != null) {
      map['sexo'] = Variable<String>(sexo);
    }
    if (!nullToAbsent || obs != null) {
      map['obs'] = Variable<String>(obs);
    }
    map['criado_em'] = Variable<DateTime>(criadoEm);
    return map;
  }

  AnimaisCompanion toCompanion(bool nullToAbsent) {
    return AnimaisCompanion(
      id: Value(id),
      loteId: Value(loteId),
      sequencia: Value(sequencia),
      pesoG: Value(pesoG),
      brinco: brinco == null && nullToAbsent
          ? const Value.absent()
          : Value(brinco),
      raca: raca == null && nullToAbsent ? const Value.absent() : Value(raca),
      sexo: sexo == null && nullToAbsent ? const Value.absent() : Value(sexo),
      obs: obs == null && nullToAbsent ? const Value.absent() : Value(obs),
      criadoEm: Value(criadoEm),
    );
  }

  factory AnimalRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnimalRow(
      id: serializer.fromJson<int>(json['id']),
      loteId: serializer.fromJson<int>(json['loteId']),
      sequencia: serializer.fromJson<int>(json['sequencia']),
      pesoG: serializer.fromJson<int>(json['pesoG']),
      brinco: serializer.fromJson<String?>(json['brinco']),
      raca: serializer.fromJson<String?>(json['raca']),
      sexo: serializer.fromJson<String?>(json['sexo']),
      obs: serializer.fromJson<String?>(json['obs']),
      criadoEm: serializer.fromJson<DateTime>(json['criadoEm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'loteId': serializer.toJson<int>(loteId),
      'sequencia': serializer.toJson<int>(sequencia),
      'pesoG': serializer.toJson<int>(pesoG),
      'brinco': serializer.toJson<String?>(brinco),
      'raca': serializer.toJson<String?>(raca),
      'sexo': serializer.toJson<String?>(sexo),
      'obs': serializer.toJson<String?>(obs),
      'criadoEm': serializer.toJson<DateTime>(criadoEm),
    };
  }

  AnimalRow copyWith({
    int? id,
    int? loteId,
    int? sequencia,
    int? pesoG,
    Value<String?> brinco = const Value.absent(),
    Value<String?> raca = const Value.absent(),
    Value<String?> sexo = const Value.absent(),
    Value<String?> obs = const Value.absent(),
    DateTime? criadoEm,
  }) => AnimalRow(
    id: id ?? this.id,
    loteId: loteId ?? this.loteId,
    sequencia: sequencia ?? this.sequencia,
    pesoG: pesoG ?? this.pesoG,
    brinco: brinco.present ? brinco.value : this.brinco,
    raca: raca.present ? raca.value : this.raca,
    sexo: sexo.present ? sexo.value : this.sexo,
    obs: obs.present ? obs.value : this.obs,
    criadoEm: criadoEm ?? this.criadoEm,
  );
  AnimalRow copyWithCompanion(AnimaisCompanion data) {
    return AnimalRow(
      id: data.id.present ? data.id.value : this.id,
      loteId: data.loteId.present ? data.loteId.value : this.loteId,
      sequencia: data.sequencia.present ? data.sequencia.value : this.sequencia,
      pesoG: data.pesoG.present ? data.pesoG.value : this.pesoG,
      brinco: data.brinco.present ? data.brinco.value : this.brinco,
      raca: data.raca.present ? data.raca.value : this.raca,
      sexo: data.sexo.present ? data.sexo.value : this.sexo,
      obs: data.obs.present ? data.obs.value : this.obs,
      criadoEm: data.criadoEm.present ? data.criadoEm.value : this.criadoEm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnimalRow(')
          ..write('id: $id, ')
          ..write('loteId: $loteId, ')
          ..write('sequencia: $sequencia, ')
          ..write('pesoG: $pesoG, ')
          ..write('brinco: $brinco, ')
          ..write('raca: $raca, ')
          ..write('sexo: $sexo, ')
          ..write('obs: $obs, ')
          ..write('criadoEm: $criadoEm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    loteId,
    sequencia,
    pesoG,
    brinco,
    raca,
    sexo,
    obs,
    criadoEm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnimalRow &&
          other.id == this.id &&
          other.loteId == this.loteId &&
          other.sequencia == this.sequencia &&
          other.pesoG == this.pesoG &&
          other.brinco == this.brinco &&
          other.raca == this.raca &&
          other.sexo == this.sexo &&
          other.obs == this.obs &&
          other.criadoEm == this.criadoEm);
}

class AnimaisCompanion extends UpdateCompanion<AnimalRow> {
  final Value<int> id;
  final Value<int> loteId;
  final Value<int> sequencia;
  final Value<int> pesoG;
  final Value<String?> brinco;
  final Value<String?> raca;
  final Value<String?> sexo;
  final Value<String?> obs;
  final Value<DateTime> criadoEm;
  const AnimaisCompanion({
    this.id = const Value.absent(),
    this.loteId = const Value.absent(),
    this.sequencia = const Value.absent(),
    this.pesoG = const Value.absent(),
    this.brinco = const Value.absent(),
    this.raca = const Value.absent(),
    this.sexo = const Value.absent(),
    this.obs = const Value.absent(),
    this.criadoEm = const Value.absent(),
  });
  AnimaisCompanion.insert({
    this.id = const Value.absent(),
    required int loteId,
    required int sequencia,
    required int pesoG,
    this.brinco = const Value.absent(),
    this.raca = const Value.absent(),
    this.sexo = const Value.absent(),
    this.obs = const Value.absent(),
    required DateTime criadoEm,
  }) : loteId = Value(loteId),
       sequencia = Value(sequencia),
       pesoG = Value(pesoG),
       criadoEm = Value(criadoEm);
  static Insertable<AnimalRow> custom({
    Expression<int>? id,
    Expression<int>? loteId,
    Expression<int>? sequencia,
    Expression<int>? pesoG,
    Expression<String>? brinco,
    Expression<String>? raca,
    Expression<String>? sexo,
    Expression<String>? obs,
    Expression<DateTime>? criadoEm,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (loteId != null) 'lote_id': loteId,
      if (sequencia != null) 'sequencia': sequencia,
      if (pesoG != null) 'peso_g': pesoG,
      if (brinco != null) 'brinco': brinco,
      if (raca != null) 'raca': raca,
      if (sexo != null) 'sexo': sexo,
      if (obs != null) 'obs': obs,
      if (criadoEm != null) 'criado_em': criadoEm,
    });
  }

  AnimaisCompanion copyWith({
    Value<int>? id,
    Value<int>? loteId,
    Value<int>? sequencia,
    Value<int>? pesoG,
    Value<String?>? brinco,
    Value<String?>? raca,
    Value<String?>? sexo,
    Value<String?>? obs,
    Value<DateTime>? criadoEm,
  }) {
    return AnimaisCompanion(
      id: id ?? this.id,
      loteId: loteId ?? this.loteId,
      sequencia: sequencia ?? this.sequencia,
      pesoG: pesoG ?? this.pesoG,
      brinco: brinco ?? this.brinco,
      raca: raca ?? this.raca,
      sexo: sexo ?? this.sexo,
      obs: obs ?? this.obs,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (loteId.present) {
      map['lote_id'] = Variable<int>(loteId.value);
    }
    if (sequencia.present) {
      map['sequencia'] = Variable<int>(sequencia.value);
    }
    if (pesoG.present) {
      map['peso_g'] = Variable<int>(pesoG.value);
    }
    if (brinco.present) {
      map['brinco'] = Variable<String>(brinco.value);
    }
    if (raca.present) {
      map['raca'] = Variable<String>(raca.value);
    }
    if (sexo.present) {
      map['sexo'] = Variable<String>(sexo.value);
    }
    if (obs.present) {
      map['obs'] = Variable<String>(obs.value);
    }
    if (criadoEm.present) {
      map['criado_em'] = Variable<DateTime>(criadoEm.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnimaisCompanion(')
          ..write('id: $id, ')
          ..write('loteId: $loteId, ')
          ..write('sequencia: $sequencia, ')
          ..write('pesoG: $pesoG, ')
          ..write('brinco: $brinco, ')
          ..write('raca: $raca, ')
          ..write('sexo: $sexo, ')
          ..write('obs: $obs, ')
          ..write('criadoEm: $criadoEm')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LotesTable lotes = $LotesTable(this);
  late final $RegrasPrecoTable regrasPreco = $RegrasPrecoTable(this);
  late final $AnimaisTable animais = $AnimaisTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    lotes,
    regrasPreco,
    animais,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'lotes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('regras_preco', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'lotes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('animais', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$LotesTableCreateCompanionBuilder =
    LotesCompanion Function({
      Value<int> id,
      required String nome,
      required DateTime data,
      Value<String?> contraparte,
      Value<String?> obs,
      required CriterioBase criterioBase,
      required int precoBaseCentavos,
      Value<int> rendimentoBp,
      Value<String?> racaPadrao,
      required DateTime criadoEm,
      required DateTime atualizadoEm,
    });
typedef $$LotesTableUpdateCompanionBuilder =
    LotesCompanion Function({
      Value<int> id,
      Value<String> nome,
      Value<DateTime> data,
      Value<String?> contraparte,
      Value<String?> obs,
      Value<CriterioBase> criterioBase,
      Value<int> precoBaseCentavos,
      Value<int> rendimentoBp,
      Value<String?> racaPadrao,
      Value<DateTime> criadoEm,
      Value<DateTime> atualizadoEm,
    });

final class $$LotesTableReferences
    extends BaseReferences<_$AppDatabase, $LotesTable, LoteRow> {
  $$LotesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RegrasPrecoTable, List<RegraPrecoRow>>
  _regrasPrecoRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.regrasPreco,
    aliasName: $_aliasNameGenerator(db.lotes.id, db.regrasPreco.loteId),
  );

  $$RegrasPrecoTableProcessedTableManager get regrasPrecoRefs {
    final manager = $$RegrasPrecoTableTableManager(
      $_db,
      $_db.regrasPreco,
    ).filter((f) => f.loteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_regrasPrecoRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AnimaisTable, List<AnimalRow>> _animaisRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.animais,
    aliasName: $_aliasNameGenerator(db.lotes.id, db.animais.loteId),
  );

  $$AnimaisTableProcessedTableManager get animaisRefs {
    final manager = $$AnimaisTableTableManager(
      $_db,
      $_db.animais,
    ).filter((f) => f.loteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_animaisRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LotesTableFilterComposer extends Composer<_$AppDatabase, $LotesTable> {
  $$LotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contraparte => $composableBuilder(
    column: $table.contraparte,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get obs => $composableBuilder(
    column: $table.obs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CriterioBase, CriterioBase, int>
  get criterioBase => $composableBuilder(
    column: $table.criterioBase,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get precoBaseCentavos => $composableBuilder(
    column: $table.precoBaseCentavos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rendimentoBp => $composableBuilder(
    column: $table.rendimentoBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get racaPadrao => $composableBuilder(
    column: $table.racaPadrao,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
    column: $table.criadoEm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get atualizadoEm => $composableBuilder(
    column: $table.atualizadoEm,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> regrasPrecoRefs(
    Expression<bool> Function($$RegrasPrecoTableFilterComposer f) f,
  ) {
    final $$RegrasPrecoTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.regrasPreco,
      getReferencedColumn: (t) => t.loteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegrasPrecoTableFilterComposer(
            $db: $db,
            $table: $db.regrasPreco,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> animaisRefs(
    Expression<bool> Function($$AnimaisTableFilterComposer f) f,
  ) {
    final $$AnimaisTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.animais,
      getReferencedColumn: (t) => t.loteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimaisTableFilterComposer(
            $db: $db,
            $table: $db.animais,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LotesTableOrderingComposer
    extends Composer<_$AppDatabase, $LotesTable> {
  $$LotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contraparte => $composableBuilder(
    column: $table.contraparte,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get obs => $composableBuilder(
    column: $table.obs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get criterioBase => $composableBuilder(
    column: $table.criterioBase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precoBaseCentavos => $composableBuilder(
    column: $table.precoBaseCentavos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rendimentoBp => $composableBuilder(
    column: $table.rendimentoBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get racaPadrao => $composableBuilder(
    column: $table.racaPadrao,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
    column: $table.criadoEm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get atualizadoEm => $composableBuilder(
    column: $table.atualizadoEm,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LotesTable> {
  $$LotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<DateTime> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<String> get contraparte => $composableBuilder(
    column: $table.contraparte,
    builder: (column) => column,
  );

  GeneratedColumn<String> get obs =>
      $composableBuilder(column: $table.obs, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CriterioBase, int> get criterioBase =>
      $composableBuilder(
        column: $table.criterioBase,
        builder: (column) => column,
      );

  GeneratedColumn<int> get precoBaseCentavos => $composableBuilder(
    column: $table.precoBaseCentavos,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rendimentoBp => $composableBuilder(
    column: $table.rendimentoBp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get racaPadrao => $composableBuilder(
    column: $table.racaPadrao,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  GeneratedColumn<DateTime> get atualizadoEm => $composableBuilder(
    column: $table.atualizadoEm,
    builder: (column) => column,
  );

  Expression<T> regrasPrecoRefs<T extends Object>(
    Expression<T> Function($$RegrasPrecoTableAnnotationComposer a) f,
  ) {
    final $$RegrasPrecoTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.regrasPreco,
      getReferencedColumn: (t) => t.loteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RegrasPrecoTableAnnotationComposer(
            $db: $db,
            $table: $db.regrasPreco,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> animaisRefs<T extends Object>(
    Expression<T> Function($$AnimaisTableAnnotationComposer a) f,
  ) {
    final $$AnimaisTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.animais,
      getReferencedColumn: (t) => t.loteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimaisTableAnnotationComposer(
            $db: $db,
            $table: $db.animais,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LotesTable,
          LoteRow,
          $$LotesTableFilterComposer,
          $$LotesTableOrderingComposer,
          $$LotesTableAnnotationComposer,
          $$LotesTableCreateCompanionBuilder,
          $$LotesTableUpdateCompanionBuilder,
          (LoteRow, $$LotesTableReferences),
          LoteRow,
          PrefetchHooks Function({bool regrasPrecoRefs, bool animaisRefs})
        > {
  $$LotesTableTableManager(_$AppDatabase db, $LotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<DateTime> data = const Value.absent(),
                Value<String?> contraparte = const Value.absent(),
                Value<String?> obs = const Value.absent(),
                Value<CriterioBase> criterioBase = const Value.absent(),
                Value<int> precoBaseCentavos = const Value.absent(),
                Value<int> rendimentoBp = const Value.absent(),
                Value<String?> racaPadrao = const Value.absent(),
                Value<DateTime> criadoEm = const Value.absent(),
                Value<DateTime> atualizadoEm = const Value.absent(),
              }) => LotesCompanion(
                id: id,
                nome: nome,
                data: data,
                contraparte: contraparte,
                obs: obs,
                criterioBase: criterioBase,
                precoBaseCentavos: precoBaseCentavos,
                rendimentoBp: rendimentoBp,
                racaPadrao: racaPadrao,
                criadoEm: criadoEm,
                atualizadoEm: atualizadoEm,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nome,
                required DateTime data,
                Value<String?> contraparte = const Value.absent(),
                Value<String?> obs = const Value.absent(),
                required CriterioBase criterioBase,
                required int precoBaseCentavos,
                Value<int> rendimentoBp = const Value.absent(),
                Value<String?> racaPadrao = const Value.absent(),
                required DateTime criadoEm,
                required DateTime atualizadoEm,
              }) => LotesCompanion.insert(
                id: id,
                nome: nome,
                data: data,
                contraparte: contraparte,
                obs: obs,
                criterioBase: criterioBase,
                precoBaseCentavos: precoBaseCentavos,
                rendimentoBp: rendimentoBp,
                racaPadrao: racaPadrao,
                criadoEm: criadoEm,
                atualizadoEm: atualizadoEm,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$LotesTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({regrasPrecoRefs = false, animaisRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (regrasPrecoRefs) db.regrasPreco,
                    if (animaisRefs) db.animais,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (regrasPrecoRefs)
                        await $_getPrefetchedData<
                          LoteRow,
                          $LotesTable,
                          RegraPrecoRow
                        >(
                          currentTable: table,
                          referencedTable: $$LotesTableReferences
                              ._regrasPrecoRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LotesTableReferences(
                                db,
                                table,
                                p0,
                              ).regrasPrecoRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.loteId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (animaisRefs)
                        await $_getPrefetchedData<
                          LoteRow,
                          $LotesTable,
                          AnimalRow
                        >(
                          currentTable: table,
                          referencedTable: $$LotesTableReferences
                              ._animaisRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LotesTableReferences(db, table, p0).animaisRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.loteId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LotesTable,
      LoteRow,
      $$LotesTableFilterComposer,
      $$LotesTableOrderingComposer,
      $$LotesTableAnnotationComposer,
      $$LotesTableCreateCompanionBuilder,
      $$LotesTableUpdateCompanionBuilder,
      (LoteRow, $$LotesTableReferences),
      LoteRow,
      PrefetchHooks Function({bool regrasPrecoRefs, bool animaisRefs})
    >;
typedef $$RegrasPrecoTableCreateCompanionBuilder =
    RegrasPrecoCompanion Function({
      Value<int> id,
      required int loteId,
      required int ordem,
      Value<int?> pesoMinG,
      Value<int?> pesoMaxG,
      Value<String?> raca,
      required int precoCentavos,
      Value<int?> rendimentoBp,
    });
typedef $$RegrasPrecoTableUpdateCompanionBuilder =
    RegrasPrecoCompanion Function({
      Value<int> id,
      Value<int> loteId,
      Value<int> ordem,
      Value<int?> pesoMinG,
      Value<int?> pesoMaxG,
      Value<String?> raca,
      Value<int> precoCentavos,
      Value<int?> rendimentoBp,
    });

final class $$RegrasPrecoTableReferences
    extends BaseReferences<_$AppDatabase, $RegrasPrecoTable, RegraPrecoRow> {
  $$RegrasPrecoTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LotesTable _loteIdTable(_$AppDatabase db) => db.lotes.createAlias(
    $_aliasNameGenerator(db.regrasPreco.loteId, db.lotes.id),
  );

  $$LotesTableProcessedTableManager get loteId {
    final $_column = $_itemColumn<int>('lote_id')!;

    final manager = $$LotesTableTableManager(
      $_db,
      $_db.lotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_loteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RegrasPrecoTableFilterComposer
    extends Composer<_$AppDatabase, $RegrasPrecoTable> {
  $$RegrasPrecoTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordem => $composableBuilder(
    column: $table.ordem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pesoMinG => $composableBuilder(
    column: $table.pesoMinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pesoMaxG => $composableBuilder(
    column: $table.pesoMaxG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get raca => $composableBuilder(
    column: $table.raca,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precoCentavos => $composableBuilder(
    column: $table.precoCentavos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rendimentoBp => $composableBuilder(
    column: $table.rendimentoBp,
    builder: (column) => ColumnFilters(column),
  );

  $$LotesTableFilterComposer get loteId {
    final $$LotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loteId,
      referencedTable: $db.lotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LotesTableFilterComposer(
            $db: $db,
            $table: $db.lotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegrasPrecoTableOrderingComposer
    extends Composer<_$AppDatabase, $RegrasPrecoTable> {
  $$RegrasPrecoTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordem => $composableBuilder(
    column: $table.ordem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pesoMinG => $composableBuilder(
    column: $table.pesoMinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pesoMaxG => $composableBuilder(
    column: $table.pesoMaxG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get raca => $composableBuilder(
    column: $table.raca,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precoCentavos => $composableBuilder(
    column: $table.precoCentavos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rendimentoBp => $composableBuilder(
    column: $table.rendimentoBp,
    builder: (column) => ColumnOrderings(column),
  );

  $$LotesTableOrderingComposer get loteId {
    final $$LotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loteId,
      referencedTable: $db.lotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LotesTableOrderingComposer(
            $db: $db,
            $table: $db.lotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegrasPrecoTableAnnotationComposer
    extends Composer<_$AppDatabase, $RegrasPrecoTable> {
  $$RegrasPrecoTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get ordem =>
      $composableBuilder(column: $table.ordem, builder: (column) => column);

  GeneratedColumn<int> get pesoMinG =>
      $composableBuilder(column: $table.pesoMinG, builder: (column) => column);

  GeneratedColumn<int> get pesoMaxG =>
      $composableBuilder(column: $table.pesoMaxG, builder: (column) => column);

  GeneratedColumn<String> get raca =>
      $composableBuilder(column: $table.raca, builder: (column) => column);

  GeneratedColumn<int> get precoCentavos => $composableBuilder(
    column: $table.precoCentavos,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rendimentoBp => $composableBuilder(
    column: $table.rendimentoBp,
    builder: (column) => column,
  );

  $$LotesTableAnnotationComposer get loteId {
    final $$LotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loteId,
      referencedTable: $db.lotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LotesTableAnnotationComposer(
            $db: $db,
            $table: $db.lotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RegrasPrecoTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RegrasPrecoTable,
          RegraPrecoRow,
          $$RegrasPrecoTableFilterComposer,
          $$RegrasPrecoTableOrderingComposer,
          $$RegrasPrecoTableAnnotationComposer,
          $$RegrasPrecoTableCreateCompanionBuilder,
          $$RegrasPrecoTableUpdateCompanionBuilder,
          (RegraPrecoRow, $$RegrasPrecoTableReferences),
          RegraPrecoRow,
          PrefetchHooks Function({bool loteId})
        > {
  $$RegrasPrecoTableTableManager(_$AppDatabase db, $RegrasPrecoTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RegrasPrecoTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RegrasPrecoTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RegrasPrecoTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> loteId = const Value.absent(),
                Value<int> ordem = const Value.absent(),
                Value<int?> pesoMinG = const Value.absent(),
                Value<int?> pesoMaxG = const Value.absent(),
                Value<String?> raca = const Value.absent(),
                Value<int> precoCentavos = const Value.absent(),
                Value<int?> rendimentoBp = const Value.absent(),
              }) => RegrasPrecoCompanion(
                id: id,
                loteId: loteId,
                ordem: ordem,
                pesoMinG: pesoMinG,
                pesoMaxG: pesoMaxG,
                raca: raca,
                precoCentavos: precoCentavos,
                rendimentoBp: rendimentoBp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int loteId,
                required int ordem,
                Value<int?> pesoMinG = const Value.absent(),
                Value<int?> pesoMaxG = const Value.absent(),
                Value<String?> raca = const Value.absent(),
                required int precoCentavos,
                Value<int?> rendimentoBp = const Value.absent(),
              }) => RegrasPrecoCompanion.insert(
                id: id,
                loteId: loteId,
                ordem: ordem,
                pesoMinG: pesoMinG,
                pesoMaxG: pesoMaxG,
                raca: raca,
                precoCentavos: precoCentavos,
                rendimentoBp: rendimentoBp,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RegrasPrecoTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({loteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (loteId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.loteId,
                                referencedTable: $$RegrasPrecoTableReferences
                                    ._loteIdTable(db),
                                referencedColumn: $$RegrasPrecoTableReferences
                                    ._loteIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RegrasPrecoTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RegrasPrecoTable,
      RegraPrecoRow,
      $$RegrasPrecoTableFilterComposer,
      $$RegrasPrecoTableOrderingComposer,
      $$RegrasPrecoTableAnnotationComposer,
      $$RegrasPrecoTableCreateCompanionBuilder,
      $$RegrasPrecoTableUpdateCompanionBuilder,
      (RegraPrecoRow, $$RegrasPrecoTableReferences),
      RegraPrecoRow,
      PrefetchHooks Function({bool loteId})
    >;
typedef $$AnimaisTableCreateCompanionBuilder =
    AnimaisCompanion Function({
      Value<int> id,
      required int loteId,
      required int sequencia,
      required int pesoG,
      Value<String?> brinco,
      Value<String?> raca,
      Value<String?> sexo,
      Value<String?> obs,
      required DateTime criadoEm,
    });
typedef $$AnimaisTableUpdateCompanionBuilder =
    AnimaisCompanion Function({
      Value<int> id,
      Value<int> loteId,
      Value<int> sequencia,
      Value<int> pesoG,
      Value<String?> brinco,
      Value<String?> raca,
      Value<String?> sexo,
      Value<String?> obs,
      Value<DateTime> criadoEm,
    });

final class $$AnimaisTableReferences
    extends BaseReferences<_$AppDatabase, $AnimaisTable, AnimalRow> {
  $$AnimaisTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LotesTable _loteIdTable(_$AppDatabase db) => db.lotes.createAlias(
    $_aliasNameGenerator(db.animais.loteId, db.lotes.id),
  );

  $$LotesTableProcessedTableManager get loteId {
    final $_column = $_itemColumn<int>('lote_id')!;

    final manager = $$LotesTableTableManager(
      $_db,
      $_db.lotes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_loteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AnimaisTableFilterComposer
    extends Composer<_$AppDatabase, $AnimaisTable> {
  $$AnimaisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sequencia => $composableBuilder(
    column: $table.sequencia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pesoG => $composableBuilder(
    column: $table.pesoG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brinco => $composableBuilder(
    column: $table.brinco,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get raca => $composableBuilder(
    column: $table.raca,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sexo => $composableBuilder(
    column: $table.sexo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get obs => $composableBuilder(
    column: $table.obs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get criadoEm => $composableBuilder(
    column: $table.criadoEm,
    builder: (column) => ColumnFilters(column),
  );

  $$LotesTableFilterComposer get loteId {
    final $$LotesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loteId,
      referencedTable: $db.lotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LotesTableFilterComposer(
            $db: $db,
            $table: $db.lotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnimaisTableOrderingComposer
    extends Composer<_$AppDatabase, $AnimaisTable> {
  $$AnimaisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sequencia => $composableBuilder(
    column: $table.sequencia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pesoG => $composableBuilder(
    column: $table.pesoG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brinco => $composableBuilder(
    column: $table.brinco,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get raca => $composableBuilder(
    column: $table.raca,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sexo => $composableBuilder(
    column: $table.sexo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get obs => $composableBuilder(
    column: $table.obs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get criadoEm => $composableBuilder(
    column: $table.criadoEm,
    builder: (column) => ColumnOrderings(column),
  );

  $$LotesTableOrderingComposer get loteId {
    final $$LotesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loteId,
      referencedTable: $db.lotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LotesTableOrderingComposer(
            $db: $db,
            $table: $db.lotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnimaisTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnimaisTable> {
  $$AnimaisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sequencia =>
      $composableBuilder(column: $table.sequencia, builder: (column) => column);

  GeneratedColumn<int> get pesoG =>
      $composableBuilder(column: $table.pesoG, builder: (column) => column);

  GeneratedColumn<String> get brinco =>
      $composableBuilder(column: $table.brinco, builder: (column) => column);

  GeneratedColumn<String> get raca =>
      $composableBuilder(column: $table.raca, builder: (column) => column);

  GeneratedColumn<String> get sexo =>
      $composableBuilder(column: $table.sexo, builder: (column) => column);

  GeneratedColumn<String> get obs =>
      $composableBuilder(column: $table.obs, builder: (column) => column);

  GeneratedColumn<DateTime> get criadoEm =>
      $composableBuilder(column: $table.criadoEm, builder: (column) => column);

  $$LotesTableAnnotationComposer get loteId {
    final $$LotesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.loteId,
      referencedTable: $db.lotes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LotesTableAnnotationComposer(
            $db: $db,
            $table: $db.lotes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnimaisTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnimaisTable,
          AnimalRow,
          $$AnimaisTableFilterComposer,
          $$AnimaisTableOrderingComposer,
          $$AnimaisTableAnnotationComposer,
          $$AnimaisTableCreateCompanionBuilder,
          $$AnimaisTableUpdateCompanionBuilder,
          (AnimalRow, $$AnimaisTableReferences),
          AnimalRow,
          PrefetchHooks Function({bool loteId})
        > {
  $$AnimaisTableTableManager(_$AppDatabase db, $AnimaisTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnimaisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnimaisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnimaisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> loteId = const Value.absent(),
                Value<int> sequencia = const Value.absent(),
                Value<int> pesoG = const Value.absent(),
                Value<String?> brinco = const Value.absent(),
                Value<String?> raca = const Value.absent(),
                Value<String?> sexo = const Value.absent(),
                Value<String?> obs = const Value.absent(),
                Value<DateTime> criadoEm = const Value.absent(),
              }) => AnimaisCompanion(
                id: id,
                loteId: loteId,
                sequencia: sequencia,
                pesoG: pesoG,
                brinco: brinco,
                raca: raca,
                sexo: sexo,
                obs: obs,
                criadoEm: criadoEm,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int loteId,
                required int sequencia,
                required int pesoG,
                Value<String?> brinco = const Value.absent(),
                Value<String?> raca = const Value.absent(),
                Value<String?> sexo = const Value.absent(),
                Value<String?> obs = const Value.absent(),
                required DateTime criadoEm,
              }) => AnimaisCompanion.insert(
                id: id,
                loteId: loteId,
                sequencia: sequencia,
                pesoG: pesoG,
                brinco: brinco,
                raca: raca,
                sexo: sexo,
                obs: obs,
                criadoEm: criadoEm,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AnimaisTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({loteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (loteId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.loteId,
                                referencedTable: $$AnimaisTableReferences
                                    ._loteIdTable(db),
                                referencedColumn: $$AnimaisTableReferences
                                    ._loteIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AnimaisTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnimaisTable,
      AnimalRow,
      $$AnimaisTableFilterComposer,
      $$AnimaisTableOrderingComposer,
      $$AnimaisTableAnnotationComposer,
      $$AnimaisTableCreateCompanionBuilder,
      $$AnimaisTableUpdateCompanionBuilder,
      (AnimalRow, $$AnimaisTableReferences),
      AnimalRow,
      PrefetchHooks Function({bool loteId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LotesTableTableManager get lotes =>
      $$LotesTableTableManager(_db, _db.lotes);
  $$RegrasPrecoTableTableManager get regrasPreco =>
      $$RegrasPrecoTableTableManager(_db, _db.regrasPreco);
  $$AnimaisTableTableManager get animais =>
      $$AnimaisTableTableManager(_db, _db.animais);
}
