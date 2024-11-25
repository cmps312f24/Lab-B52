// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ProjectDao? _projectDaoInstance;

  TodoDao? _todoDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `projects` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `todos` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `status` TEXT NOT NULL, `priority` TEXT NOT NULL, `date` TEXT NOT NULL, `time` TEXT NOT NULL, `pid` INTEGER NOT NULL, FOREIGN KEY (`pid`) REFERENCES `projects` (`id`) ON UPDATE CASCADE ON DELETE CASCADE)');

        await database.execute(
            'CREATE VIEW IF NOT EXISTS `ProjectTodoStatusCounts` AS   SELECT p.id AS id,\n    IFNULL(SUM(CASE WHEN t.status = \'Pending\' THEN 1 ELSE 0 END), 0) AS pendingCount,\n    IFNULL(SUM(CASE WHEN t.status = \'Completed\' THEN 1 ELSE 0 END), 0) AS completedCount\n  FROM projects p\n  LEFT JOIN todos t ON p.id = t.pid\n  GROUP BY p.id\n  ');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ProjectDao get projectDao {
    return _projectDaoInstance ??= _$ProjectDao(database, changeListener);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }
}

class _$ProjectDao extends ProjectDao {
  _$ProjectDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _projectInsertionAdapter = InsertionAdapter(
            database,
            'projects',
            (Project item) =>
                <String, Object?>{'id': item.id, 'name': item.name},
            changeListener),
        _projectUpdateAdapter = UpdateAdapter(
            database,
            'projects',
            ['id'],
            (Project item) =>
                <String, Object?>{'id': item.id, 'name': item.name},
            changeListener),
        _projectDeletionAdapter = DeletionAdapter(
            database,
            'projects',
            ['id'],
            (Project item) =>
                <String, Object?>{'id': item.id, 'name': item.name},
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Project> _projectInsertionAdapter;

  final UpdateAdapter<Project> _projectUpdateAdapter;

  final DeletionAdapter<Project> _projectDeletionAdapter;

  @override
  Stream<List<Project>> observeProjects() {
    return _queryAdapter.queryListStream('SELECT * FROM projects',
        mapper: (Map<String, Object?> row) =>
            Project(row['id'] as int?, row['name'] as String),
        queryableName: 'projects',
        isView: false);
  }

  @override
  Stream<ProjectTodoStatusCounts?> observeProjectTodoStatusCounts(int pid) {
    return _queryAdapter.queryStream(
        'SELECT * FROM ProjectTodoStatusCounts WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ProjectTodoStatusCounts(
            id: row['id'] as int,
            pendingCount: row['pendingCount'] as int,
            completedCount: row['completedCount'] as int),
        arguments: [pid],
        queryableName: 'ProjectTodoStatusCounts',
        isView: true);
  }

  @override
  Future<void> addProject(Project project) async {
    await _projectInsertionAdapter.insert(project, OnConflictStrategy.abort);
  }

  @override
  Future<void> upsertProject(Project project) async {
    await _projectInsertionAdapter.insert(project, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateProject(Project project) async {
    await _projectUpdateAdapter.update(project, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteProject(Project project) async {
    await _projectDeletionAdapter.delete(project);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _todoInsertionAdapter = InsertionAdapter(
            database,
            'todos',
            (Todo item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'status': item.status,
                  'priority': item.priority,
                  'date': item.date,
                  'time': item.time,
                  'pid': item.pid
                },
            changeListener),
        _todoUpdateAdapter = UpdateAdapter(
            database,
            'todos',
            ['id'],
            (Todo item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'status': item.status,
                  'priority': item.priority,
                  'date': item.date,
                  'time': item.time,
                  'pid': item.pid
                },
            changeListener),
        _todoDeletionAdapter = DeletionAdapter(
            database,
            'todos',
            ['id'],
            (Todo item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'status': item.status,
                  'priority': item.priority,
                  'date': item.date,
                  'time': item.time,
                  'pid': item.pid
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Todo> _todoInsertionAdapter;

  final UpdateAdapter<Todo> _todoUpdateAdapter;

  final DeletionAdapter<Todo> _todoDeletionAdapter;

  @override
  Stream<List<Todo>> observeTodos(int pid) {
    return _queryAdapter.queryListStream('SELECT * FROM todos WHERE pid = ?1',
        mapper: (Map<String, Object?> row) => Todo(
            row['id'] as int?,
            row['title'] as String,
            row['status'] as String,
            row['priority'] as String,
            row['date'] as String,
            row['time'] as String,
            row['pid'] as int),
        arguments: [pid],
        queryableName: 'todos',
        isView: false);
  }

  @override
  Stream<Todo?> getTodo(int id) {
    return _queryAdapter.queryStream('SELECT * FROM todos WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Todo(
            row['id'] as int?,
            row['title'] as String,
            row['status'] as String,
            row['priority'] as String,
            row['date'] as String,
            row['time'] as String,
            row['pid'] as int),
        arguments: [id],
        queryableName: 'todos',
        isView: false);
  }

  @override
  Future<void> addTodo(Todo todo) async {
    await _todoInsertionAdapter.insert(todo, OnConflictStrategy.abort);
  }

  @override
  Future<void> upsertTodo(Todo todo) async {
    await _todoInsertionAdapter.insert(todo, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    await _todoUpdateAdapter.update(todo, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await _todoDeletionAdapter.delete(todo);
  }
}
