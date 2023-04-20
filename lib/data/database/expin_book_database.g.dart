// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expin_book_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorExpinBookDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ExpinBookDatabaseBuilder databaseBuilder(String name) =>
      _$ExpinBookDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$ExpinBookDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$ExpinBookDatabaseBuilder(null);
}

class _$ExpinBookDatabaseBuilder {
  _$ExpinBookDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$ExpinBookDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$ExpinBookDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<ExpinBookDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ExpinBookDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ExpinBookDatabase extends ExpinBookDatabase {
  _$ExpinBookDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CategoryDao? _categoryDaoInstance;

  PaymentDao? _paymentDaoInstance;

  ExpinDao? _expinDaoInstance;

  BudgetDao? _budgetDaoInstance;

  LoanDao? _loanDaoInstance;

  LoanTransactionDao? _loanTransactionDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Category` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `isIncome` INTEGER NOT NULL, `iconIndex` INTEGER, `symbol` TEXT, `color` INTEGER NOT NULL, `description` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Payment` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `mode` INTEGER NOT NULL, `description` TEXT, `color` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Expin` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `amount` REAL NOT NULL, `type` INTEGER NOT NULL, `categoryId` INTEGER NOT NULL, `paymentId` INTEGER NOT NULL, `toPaymentId` INTEGER, `description` TEXT, `imagePath` TEXT, `dateTime` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Budget` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `amount` REAL NOT NULL, `budgetForCategories` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Loan` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `interest` REAL NOT NULL, `iconIndex` INTEGER, `symbol` TEXT, `color` INTEGER NOT NULL, `description` TEXT, `dateTime` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `LoanTransaction` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `amount` REAL NOT NULL, `loanId` INTEGER NOT NULL, `description` TEXT, `imagePath` TEXT, `dateTime` TEXT NOT NULL, `isPay` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CategoryDao get categoryDao {
    return _categoryDaoInstance ??= _$CategoryDao(database, changeListener);
  }

  @override
  PaymentDao get paymentDao {
    return _paymentDaoInstance ??= _$PaymentDao(database, changeListener);
  }

  @override
  ExpinDao get expinDao {
    return _expinDaoInstance ??= _$ExpinDao(database, changeListener);
  }

  @override
  BudgetDao get budgetDao {
    return _budgetDaoInstance ??= _$BudgetDao(database, changeListener);
  }

  @override
  LoanDao get loanDao {
    return _loanDaoInstance ??= _$LoanDao(database, changeListener);
  }

  @override
  LoanTransactionDao get loanTransactionDao {
    return _loanTransactionDaoInstance ??=
        _$LoanTransactionDao(database, changeListener);
  }
}

class _$CategoryDao extends CategoryDao {
  _$CategoryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _categoryInsertionAdapter = InsertionAdapter(
            database,
            'Category',
            (Category item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isIncome': item.isIncome ? 1 : 0,
                  'iconIndex': item.iconIndex,
                  'symbol': item.symbol,
                  'color': _colorConverter.encode(item.color),
                  'description': item.description
                },
            changeListener),
        _categoryUpdateAdapter = UpdateAdapter(
            database,
            'Category',
            ['id'],
            (Category item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isIncome': item.isIncome ? 1 : 0,
                  'iconIndex': item.iconIndex,
                  'symbol': item.symbol,
                  'color': _colorConverter.encode(item.color),
                  'description': item.description
                },
            changeListener),
        _categoryDeletionAdapter = DeletionAdapter(
            database,
            'Category',
            ['id'],
            (Category item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isIncome': item.isIncome ? 1 : 0,
                  'iconIndex': item.iconIndex,
                  'symbol': item.symbol,
                  'color': _colorConverter.encode(item.color),
                  'description': item.description
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Category> _categoryInsertionAdapter;

  final UpdateAdapter<Category> _categoryUpdateAdapter;

  final DeletionAdapter<Category> _categoryDeletionAdapter;

  @override
  Future<Category?> findCategoryWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM Category WHERE id =?1',
        mapper: (Map<String, Object?> row) => Category(
            id: row['id'] as int?,
            name: row['name'] as String,
            isIncome: (row['isIncome'] as int) != 0,
            iconIndex: row['iconIndex'] as int?,
            symbol: row['symbol'] as String?,
            color: _colorConverter.decode(row['color'] as int),
            description: row['description'] as String?),
        arguments: [id]);
  }

  @override
  Stream<Category?> watchCategoryWithId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Category WHERE id =?1',
        mapper: (Map<String, Object?> row) => Category(
            id: row['id'] as int?,
            name: row['name'] as String,
            isIncome: (row['isIncome'] as int) != 0,
            iconIndex: row['iconIndex'] as int?,
            symbol: row['symbol'] as String?,
            color: _colorConverter.decode(row['color'] as int),
            description: row['description'] as String?),
        arguments: [id],
        queryableName: 'Category',
        isView: false);
  }

  @override
  Future<List<Category>> findAllCategories() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Category ORDER BY isIncome DESC',
        mapper: (Map<String, Object?> row) => Category(
            id: row['id'] as int?,
            name: row['name'] as String,
            isIncome: (row['isIncome'] as int) != 0,
            iconIndex: row['iconIndex'] as int?,
            symbol: row['symbol'] as String?,
            color: _colorConverter.decode(row['color'] as int),
            description: row['description'] as String?));
  }

  @override
  Stream<List<Category>> watchAllCategories() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Category ORDER BY isIncome DESC',
        mapper: (Map<String, Object?> row) => Category(
            id: row['id'] as int?,
            name: row['name'] as String,
            isIncome: (row['isIncome'] as int) != 0,
            iconIndex: row['iconIndex'] as int?,
            symbol: row['symbol'] as String?,
            color: _colorConverter.decode(row['color'] as int),
            description: row['description'] as String?),
        queryableName: 'Category',
        isView: false);
  }

  @override
  Future<int> insertCategory(Category category) {
    return _categoryInsertionAdapter.insertAndReturnId(
        category, OnConflictStrategy.ignore);
  }

  @override
  Future<List<int>> insertAllCategories(List<Category> categories) {
    return _categoryInsertionAdapter.insertListAndReturnIds(
        categories, OnConflictStrategy.ignore);
  }

  @override
  Future<int> updateCategory(Category category) {
    return _categoryUpdateAdapter.updateAndReturnChangedRows(
        category, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateAllCategories(List<Category> categories) {
    return _categoryUpdateAdapter.updateListAndReturnChangedRows(
        categories, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteCategory(Category category) {
    return _categoryDeletionAdapter.deleteAndReturnChangedRows(category);
  }

  @override
  Future<int> deleteAllCategories(List<Category> categories) {
    return _categoryDeletionAdapter.deleteListAndReturnChangedRows(categories);
  }
}

class _$PaymentDao extends PaymentDao {
  _$PaymentDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _paymentInsertionAdapter = InsertionAdapter(
            database,
            'Payment',
            (Payment item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'mode': _paymentModeConverter.encode(item.mode),
                  'description': item.description,
                  'color': _colorConverter.encode(item.color)
                },
            changeListener),
        _paymentUpdateAdapter = UpdateAdapter(
            database,
            'Payment',
            ['id'],
            (Payment item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'mode': _paymentModeConverter.encode(item.mode),
                  'description': item.description,
                  'color': _colorConverter.encode(item.color)
                },
            changeListener),
        _paymentDeletionAdapter = DeletionAdapter(
            database,
            'Payment',
            ['id'],
            (Payment item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'mode': _paymentModeConverter.encode(item.mode),
                  'description': item.description,
                  'color': _colorConverter.encode(item.color)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Payment> _paymentInsertionAdapter;

  final UpdateAdapter<Payment> _paymentUpdateAdapter;

  final DeletionAdapter<Payment> _paymentDeletionAdapter;

  @override
  Future<Payment?> findPaymentWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM Payment WHERE id =?1',
        mapper: (Map<String, Object?> row) => Payment(
            id: row['id'] as int?,
            name: row['name'] as String,
            mode: _paymentModeConverter.decode(row['mode'] as int),
            description: row['description'] as String?,
            color: _colorConverter.decode(row['color'] as int)),
        arguments: [id]);
  }

  @override
  Stream<Payment?> watchPaymentWithId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Payment WHERE id =?1',
        mapper: (Map<String, Object?> row) => Payment(
            id: row['id'] as int?,
            name: row['name'] as String,
            mode: _paymentModeConverter.decode(row['mode'] as int),
            description: row['description'] as String?,
            color: _colorConverter.decode(row['color'] as int)),
        arguments: [id],
        queryableName: 'Payment',
        isView: false);
  }

  @override
  Future<List<Payment>> findAllPayments() async {
    return _queryAdapter.queryList('SELECT * FROM Payment',
        mapper: (Map<String, Object?> row) => Payment(
            id: row['id'] as int?,
            name: row['name'] as String,
            mode: _paymentModeConverter.decode(row['mode'] as int),
            description: row['description'] as String?,
            color: _colorConverter.decode(row['color'] as int)));
  }

  @override
  Stream<List<Payment>> watchAllPayments() {
    return _queryAdapter.queryListStream('SELECT * FROM Payment',
        mapper: (Map<String, Object?> row) => Payment(
            id: row['id'] as int?,
            name: row['name'] as String,
            mode: _paymentModeConverter.decode(row['mode'] as int),
            description: row['description'] as String?,
            color: _colorConverter.decode(row['color'] as int)),
        queryableName: 'Payment',
        isView: false);
  }

  @override
  Future<int> insertPayment(Payment payment) {
    return _paymentInsertionAdapter.insertAndReturnId(
        payment, OnConflictStrategy.ignore);
  }

  @override
  Future<List<int>> insertAllPayments(List<Payment> payments) {
    return _paymentInsertionAdapter.insertListAndReturnIds(
        payments, OnConflictStrategy.ignore);
  }

  @override
  Future<int> updatePayment(Payment payment) {
    return _paymentUpdateAdapter.updateAndReturnChangedRows(
        payment, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateAllPayments(List<Payment> payments) {
    return _paymentUpdateAdapter.updateListAndReturnChangedRows(
        payments, OnConflictStrategy.replace);
  }

  @override
  Future<int> deletePayment(Payment payment) {
    return _paymentDeletionAdapter.deleteAndReturnChangedRows(payment);
  }

  @override
  Future<int> deleteAllPayments(List<Payment> payments) {
    return _paymentDeletionAdapter.deleteListAndReturnChangedRows(payments);
  }
}

class _$ExpinDao extends ExpinDao {
  _$ExpinDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _expinInsertionAdapter = InsertionAdapter(
            database,
            'Expin',
            (Expin item) => <String, Object?>{
                  'id': item.id,
                  'amount': item.amount,
                  'type': _transactionTypeConverter.encode(item.type),
                  'categoryId': item.categoryId,
                  'paymentId': item.paymentId,
                  'toPaymentId': item.toPaymentId,
                  'description': item.description,
                  'imagePath': item.imagePath,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                },
            changeListener),
        _expinUpdateAdapter = UpdateAdapter(
            database,
            'Expin',
            ['id'],
            (Expin item) => <String, Object?>{
                  'id': item.id,
                  'amount': item.amount,
                  'type': _transactionTypeConverter.encode(item.type),
                  'categoryId': item.categoryId,
                  'paymentId': item.paymentId,
                  'toPaymentId': item.toPaymentId,
                  'description': item.description,
                  'imagePath': item.imagePath,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                },
            changeListener),
        _expinDeletionAdapter = DeletionAdapter(
            database,
            'Expin',
            ['id'],
            (Expin item) => <String, Object?>{
                  'id': item.id,
                  'amount': item.amount,
                  'type': _transactionTypeConverter.encode(item.type),
                  'categoryId': item.categoryId,
                  'paymentId': item.paymentId,
                  'toPaymentId': item.toPaymentId,
                  'description': item.description,
                  'imagePath': item.imagePath,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Expin> _expinInsertionAdapter;

  final UpdateAdapter<Expin> _expinUpdateAdapter;

  final DeletionAdapter<Expin> _expinDeletionAdapter;

  @override
  Future<Expin?> findExpinWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM Expin WHERE id =?1',
        mapper: (Map<String, Object?> row) => Expin(
            id: row['id'] as int?,
            amount: row['amount'] as double,
            type: _transactionTypeConverter.decode(row['type'] as int),
            categoryId: row['categoryId'] as int,
            paymentId: row['paymentId'] as int,
            toPaymentId: row['toPaymentId'] as int?,
            description: row['description'] as String?,
            imagePath: row['imagePath'] as String?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as String)),
        arguments: [id]);
  }

  @override
  Stream<Expin?> watchExpinWithId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Expin WHERE id =?1',
        mapper: (Map<String, Object?> row) => Expin(
            id: row['id'] as int?,
            amount: row['amount'] as double,
            type: _transactionTypeConverter.decode(row['type'] as int),
            categoryId: row['categoryId'] as int,
            paymentId: row['paymentId'] as int,
            toPaymentId: row['toPaymentId'] as int?,
            description: row['description'] as String?,
            imagePath: row['imagePath'] as String?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as String)),
        arguments: [id],
        queryableName: 'Expin',
        isView: false);
  }

  @override
  Future<List<Expin>> findAllExpins() async {
    return _queryAdapter.queryList('SELECT * FROM Expin ORDER BY dateTime DESC',
        mapper: (Map<String, Object?> row) => Expin(
            id: row['id'] as int?,
            amount: row['amount'] as double,
            type: _transactionTypeConverter.decode(row['type'] as int),
            categoryId: row['categoryId'] as int,
            paymentId: row['paymentId'] as int,
            toPaymentId: row['toPaymentId'] as int?,
            description: row['description'] as String?,
            imagePath: row['imagePath'] as String?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as String)));
  }

  @override
  Stream<List<Expin>> watchAllExpins() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Expin ORDER BY dateTime DESC',
        mapper: (Map<String, Object?> row) => Expin(
            id: row['id'] as int?,
            amount: row['amount'] as double,
            type: _transactionTypeConverter.decode(row['type'] as int),
            categoryId: row['categoryId'] as int,
            paymentId: row['paymentId'] as int,
            toPaymentId: row['toPaymentId'] as int?,
            description: row['description'] as String?,
            imagePath: row['imagePath'] as String?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as String)),
        queryableName: 'Expin',
        isView: false);
  }

  @override
  Future<int> insertExpin(Expin expin) {
    return _expinInsertionAdapter.insertAndReturnId(
        expin, OnConflictStrategy.ignore);
  }

  @override
  Future<List<int>> insertAllExpins(List<Expin> expins) {
    return _expinInsertionAdapter.insertListAndReturnIds(
        expins, OnConflictStrategy.ignore);
  }

  @override
  Future<int> updateExpin(Expin expin) {
    return _expinUpdateAdapter.updateAndReturnChangedRows(
        expin, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateAllExpins(List<Expin> expins) {
    return _expinUpdateAdapter.updateListAndReturnChangedRows(
        expins, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteExpin(Expin expin) {
    return _expinDeletionAdapter.deleteAndReturnChangedRows(expin);
  }

  @override
  Future<int> deleteAllExpins(List<Expin> expins) {
    return _expinDeletionAdapter.deleteListAndReturnChangedRows(expins);
  }
}

class _$BudgetDao extends BudgetDao {
  _$BudgetDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _budgetInsertionAdapter = InsertionAdapter(
            database,
            'Budget',
            (Budget item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'amount': item.amount,
                  'budgetForCategories':
                      _intListConverter.encode(item.budgetForCategories)
                },
            changeListener),
        _budgetUpdateAdapter = UpdateAdapter(
            database,
            'Budget',
            ['id'],
            (Budget item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'amount': item.amount,
                  'budgetForCategories':
                      _intListConverter.encode(item.budgetForCategories)
                },
            changeListener),
        _budgetDeletionAdapter = DeletionAdapter(
            database,
            'Budget',
            ['id'],
            (Budget item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'amount': item.amount,
                  'budgetForCategories':
                      _intListConverter.encode(item.budgetForCategories)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Budget> _budgetInsertionAdapter;

  final UpdateAdapter<Budget> _budgetUpdateAdapter;

  final DeletionAdapter<Budget> _budgetDeletionAdapter;

  @override
  Future<Budget?> findFirstBudget() async {
    return _queryAdapter.query('SELECT * FROM Budget LIMIT 1',
        mapper: (Map<String, Object?> row) => Budget(
            id: row['id'] as int?,
            name: row['name'] as String,
            amount: row['amount'] as double,
            budgetForCategories: _intListConverter
                .decode(row['budgetForCategories'] as String)));
  }

  @override
  Stream<Budget?> watchFirstBudget() {
    return _queryAdapter.queryStream('SELECT * FROM Budget LIMIT 1',
        mapper: (Map<String, Object?> row) => Budget(
            id: row['id'] as int?,
            name: row['name'] as String,
            amount: row['amount'] as double,
            budgetForCategories:
                _intListConverter.decode(row['budgetForCategories'] as String)),
        queryableName: 'Budget',
        isView: false);
  }

  @override
  Future<Budget?> findBudgetWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM Budget WHERE id =?1',
        mapper: (Map<String, Object?> row) => Budget(
            id: row['id'] as int?,
            name: row['name'] as String,
            amount: row['amount'] as double,
            budgetForCategories:
                _intListConverter.decode(row['budgetForCategories'] as String)),
        arguments: [id]);
  }

  @override
  Stream<Budget?> watchBudgetWithId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Budget WHERE id =?1',
        mapper: (Map<String, Object?> row) => Budget(
            id: row['id'] as int?,
            name: row['name'] as String,
            amount: row['amount'] as double,
            budgetForCategories:
                _intListConverter.decode(row['budgetForCategories'] as String)),
        arguments: [id],
        queryableName: 'Budget',
        isView: false);
  }

  @override
  Future<List<Budget>> findAllBudgets() async {
    return _queryAdapter.queryList('SELECT * FROM Budget',
        mapper: (Map<String, Object?> row) => Budget(
            id: row['id'] as int?,
            name: row['name'] as String,
            amount: row['amount'] as double,
            budgetForCategories: _intListConverter
                .decode(row['budgetForCategories'] as String)));
  }

  @override
  Stream<List<Budget>> watchAllBudgets() {
    return _queryAdapter.queryListStream('SELECT * FROM Budget',
        mapper: (Map<String, Object?> row) => Budget(
            id: row['id'] as int?,
            name: row['name'] as String,
            amount: row['amount'] as double,
            budgetForCategories:
                _intListConverter.decode(row['budgetForCategories'] as String)),
        queryableName: 'Budget',
        isView: false);
  }

  @override
  Future<int> insertBudget(Budget budget) {
    return _budgetInsertionAdapter.insertAndReturnId(
        budget, OnConflictStrategy.ignore);
  }

  @override
  Future<List<int>> insertAllBudgets(List<Budget> budgets) {
    return _budgetInsertionAdapter.insertListAndReturnIds(
        budgets, OnConflictStrategy.ignore);
  }

  @override
  Future<int> updateBudget(Budget budget) {
    return _budgetUpdateAdapter.updateAndReturnChangedRows(
        budget, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateAllBudgets(List<Budget> budgets) {
    return _budgetUpdateAdapter.updateListAndReturnChangedRows(
        budgets, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteBudget(Budget budget) {
    return _budgetDeletionAdapter.deleteAndReturnChangedRows(budget);
  }

  @override
  Future<int> deleteAllBudgets(List<Budget> budgets) {
    return _budgetDeletionAdapter.deleteListAndReturnChangedRows(budgets);
  }
}

class _$LoanDao extends LoanDao {
  _$LoanDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _loanInsertionAdapter = InsertionAdapter(
            database,
            'Loan',
            (Loan item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'interest': item.interest,
                  'iconIndex': item.iconIndex,
                  'symbol': item.symbol,
                  'color': _colorConverter.encode(item.color),
                  'description': item.description,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                },
            changeListener),
        _loanUpdateAdapter = UpdateAdapter(
            database,
            'Loan',
            ['id'],
            (Loan item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'interest': item.interest,
                  'iconIndex': item.iconIndex,
                  'symbol': item.symbol,
                  'color': _colorConverter.encode(item.color),
                  'description': item.description,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                },
            changeListener),
        _loanDeletionAdapter = DeletionAdapter(
            database,
            'Loan',
            ['id'],
            (Loan item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'interest': item.interest,
                  'iconIndex': item.iconIndex,
                  'symbol': item.symbol,
                  'color': _colorConverter.encode(item.color),
                  'description': item.description,
                  'dateTime': _dateTimeConverter.encode(item.dateTime)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Loan> _loanInsertionAdapter;

  final UpdateAdapter<Loan> _loanUpdateAdapter;

  final DeletionAdapter<Loan> _loanDeletionAdapter;

  @override
  Future<Loan?> findLoanWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM Loan WHERE id =?1',
        mapper: (Map<String, Object?> row) => Loan(
            id: row['id'] as int?,
            name: row['name'] as String,
            interest: row['interest'] as double,
            iconIndex: row['iconIndex'] as int?,
            symbol: row['symbol'] as String?,
            color: _colorConverter.decode(row['color'] as int),
            description: row['description'] as String?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as String)),
        arguments: [id]);
  }

  @override
  Stream<Loan?> watchLoanWithId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Loan WHERE id =?1',
        mapper: (Map<String, Object?> row) => Loan(
            id: row['id'] as int?,
            name: row['name'] as String,
            interest: row['interest'] as double,
            iconIndex: row['iconIndex'] as int?,
            symbol: row['symbol'] as String?,
            color: _colorConverter.decode(row['color'] as int),
            description: row['description'] as String?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as String)),
        arguments: [id],
        queryableName: 'Loan',
        isView: false);
  }

  @override
  Future<List<Loan>> findAllLoans() async {
    return _queryAdapter.queryList('SELECT * FROM Loan',
        mapper: (Map<String, Object?> row) => Loan(
            id: row['id'] as int?,
            name: row['name'] as String,
            interest: row['interest'] as double,
            iconIndex: row['iconIndex'] as int?,
            symbol: row['symbol'] as String?,
            color: _colorConverter.decode(row['color'] as int),
            description: row['description'] as String?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as String)));
  }

  @override
  Stream<List<Loan>> watchAllLoans() {
    return _queryAdapter.queryListStream('SELECT * FROM Loan',
        mapper: (Map<String, Object?> row) => Loan(
            id: row['id'] as int?,
            name: row['name'] as String,
            interest: row['interest'] as double,
            iconIndex: row['iconIndex'] as int?,
            symbol: row['symbol'] as String?,
            color: _colorConverter.decode(row['color'] as int),
            description: row['description'] as String?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as String)),
        queryableName: 'Loan',
        isView: false);
  }

  @override
  Future<int> insertLoan(Loan loan) {
    return _loanInsertionAdapter.insertAndReturnId(
        loan, OnConflictStrategy.ignore);
  }

  @override
  Future<List<int>> insertAllLoans(List<Loan> loans) {
    return _loanInsertionAdapter.insertListAndReturnIds(
        loans, OnConflictStrategy.ignore);
  }

  @override
  Future<int> updateLoan(Loan loan) {
    return _loanUpdateAdapter.updateAndReturnChangedRows(
        loan, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateAllLoans(List<Loan> loans) {
    return _loanUpdateAdapter.updateListAndReturnChangedRows(
        loans, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteLoan(Loan loan) {
    return _loanDeletionAdapter.deleteAndReturnChangedRows(loan);
  }

  @override
  Future<int> deleteAllLoans(List<Loan> loans) {
    return _loanDeletionAdapter.deleteListAndReturnChangedRows(loans);
  }
}

class _$LoanTransactionDao extends LoanTransactionDao {
  _$LoanTransactionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _loanTransactionInsertionAdapter = InsertionAdapter(
            database,
            'LoanTransaction',
            (LoanTransaction item) => <String, Object?>{
                  'id': item.id,
                  'amount': item.amount,
                  'loanId': item.loanId,
                  'description': item.description,
                  'imagePath': item.imagePath,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'isPay': item.isPay ? 1 : 0
                },
            changeListener),
        _loanTransactionUpdateAdapter = UpdateAdapter(
            database,
            'LoanTransaction',
            ['id'],
            (LoanTransaction item) => <String, Object?>{
                  'id': item.id,
                  'amount': item.amount,
                  'loanId': item.loanId,
                  'description': item.description,
                  'imagePath': item.imagePath,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'isPay': item.isPay ? 1 : 0
                },
            changeListener),
        _loanTransactionDeletionAdapter = DeletionAdapter(
            database,
            'LoanTransaction',
            ['id'],
            (LoanTransaction item) => <String, Object?>{
                  'id': item.id,
                  'amount': item.amount,
                  'loanId': item.loanId,
                  'description': item.description,
                  'imagePath': item.imagePath,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'isPay': item.isPay ? 1 : 0
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LoanTransaction> _loanTransactionInsertionAdapter;

  final UpdateAdapter<LoanTransaction> _loanTransactionUpdateAdapter;

  final DeletionAdapter<LoanTransaction> _loanTransactionDeletionAdapter;

  @override
  Future<LoanTransaction?> findLoanTransactionWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM LoanTransaction WHERE id =?1',
        mapper: (Map<String, Object?> row) => LoanTransaction(
            id: row['id'] as int?,
            amount: row['amount'] as double,
            loanId: row['loanId'] as int,
            description: row['description'] as String?,
            imagePath: row['imagePath'] as String?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as String),
            isPay: (row['isPay'] as int) != 0),
        arguments: [id]);
  }

  @override
  Stream<LoanTransaction?> watchLoanTransactionWithId(int id) {
    return _queryAdapter.queryStream(
        'SELECT * FROM LoanTransaction WHERE id =?1',
        mapper: (Map<String, Object?> row) => LoanTransaction(
            id: row['id'] as int?,
            amount: row['amount'] as double,
            loanId: row['loanId'] as int,
            description: row['description'] as String?,
            imagePath: row['imagePath'] as String?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as String),
            isPay: (row['isPay'] as int) != 0),
        arguments: [id],
        queryableName: 'LoanTransaction',
        isView: false);
  }

  @override
  Future<List<LoanTransaction>> findAllLoanTransactionsWithLoanId(
      int loanId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM LoanTransaction WHERE loanId =?1 ORDER BY dateTime DESC',
        mapper: (Map<String, Object?> row) => LoanTransaction(
            id: row['id'] as int?,
            amount: row['amount'] as double,
            loanId: row['loanId'] as int,
            description: row['description'] as String?,
            imagePath: row['imagePath'] as String?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as String),
            isPay: (row['isPay'] as int) != 0),
        arguments: [loanId]);
  }

  @override
  Stream<List<LoanTransaction>> watchAllLoanTransactionsWithLoanId(int loanId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM LoanTransaction WHERE loanId =?1 ORDER BY dateTime DESC',
        mapper: (Map<String, Object?> row) => LoanTransaction(
            id: row['id'] as int?,
            amount: row['amount'] as double,
            loanId: row['loanId'] as int,
            description: row['description'] as String?,
            imagePath: row['imagePath'] as String?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as String),
            isPay: (row['isPay'] as int) != 0),
        arguments: [loanId],
        queryableName: 'LoanTransaction',
        isView: false);
  }

  @override
  Future<List<LoanTransaction>> findAllLoanTransactions() async {
    return _queryAdapter.queryList(
        'SELECT * FROM LoanTransaction ORDER BY dateTime DESC',
        mapper: (Map<String, Object?> row) => LoanTransaction(
            id: row['id'] as int?,
            amount: row['amount'] as double,
            loanId: row['loanId'] as int,
            description: row['description'] as String?,
            imagePath: row['imagePath'] as String?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as String),
            isPay: (row['isPay'] as int) != 0));
  }

  @override
  Stream<List<LoanTransaction>> watchAllLoanTransactions() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM LoanTransaction ORDER BY dateTime DESC',
        mapper: (Map<String, Object?> row) => LoanTransaction(
            id: row['id'] as int?,
            amount: row['amount'] as double,
            loanId: row['loanId'] as int,
            description: row['description'] as String?,
            imagePath: row['imagePath'] as String?,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as String),
            isPay: (row['isPay'] as int) != 0),
        queryableName: 'LoanTransaction',
        isView: false);
  }

  @override
  Future<int> insertLoanTransaction(LoanTransaction loanTransaction) {
    return _loanTransactionInsertionAdapter.insertAndReturnId(
        loanTransaction, OnConflictStrategy.ignore);
  }

  @override
  Future<List<int>> insertAllLoanTransactions(
      List<LoanTransaction> loanTransactions) {
    return _loanTransactionInsertionAdapter.insertListAndReturnIds(
        loanTransactions, OnConflictStrategy.ignore);
  }

  @override
  Future<int> updateLoanTransaction(LoanTransaction loanTransaction) {
    return _loanTransactionUpdateAdapter.updateAndReturnChangedRows(
        loanTransaction, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateAllLoanTransactions(
      List<LoanTransaction> loanTransactions) {
    return _loanTransactionUpdateAdapter.updateListAndReturnChangedRows(
        loanTransactions, OnConflictStrategy.replace);
  }

  @override
  Future<int> deleteLoanTransaction(LoanTransaction loanTransaction) {
    return _loanTransactionDeletionAdapter
        .deleteAndReturnChangedRows(loanTransaction);
  }

  @override
  Future<int> deleteAllLoanTransactions(
      List<LoanTransaction> loanTransactions) {
    return _loanTransactionDeletionAdapter
        .deleteListAndReturnChangedRows(loanTransactions);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _colorConverter = ColorConverter();
final _paymentModeConverter = PaymentModeConverter();
final _transactionTypeConverter = TransactionTypeConverter();
final _intListConverter = IntListConverter();
