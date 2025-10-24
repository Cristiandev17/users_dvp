# Users DVP App

Aplicación Flutter para la gestión de usuarios utilizando arquitectura limpia, patrones CQRS y Mediator, con almacenamiento local mediante Isar.

## 📋 Tabla de Contenidos

- [Descripción](#-descripción)
- [Versión del SDK](#-versión-del-sdk)
- [Arquitectura](#-arquitectura)
- [Patrones de Diseño](#-patrones-de-diseño)
- [Base de Datos - Isar](#-base-de-datos---isar)
- [Dependencias](#-dependencias)
- [Estructura del Proyecto](#-estructura-del-proyecto)
- [Uso](#-uso)

## 📖 Descripción

Users DVP App es una aplicación móvil desarrollada en Flutter que permite gestionar usuarios y sus direcciones. La aplicación implementa las mejores prácticas de desarrollo con arquitectura limpia, gestión de estado con BLoC/Cubit, y persistencia de datos local con Isar.

## 🔧 Versión del SDK

```yaml
environment:
  sdk: ^3.8.1
```

La aplicación requiere **Dart SDK 3.8.1** o superior.

## 🏗️ Arquitectura

El proyecto implementa **Clean Architecture (Arquitectura Limpia)** con una clara separación de responsabilidades en capas:

### Capas de la Arquitectura

```
lib/
├── core/                 # Funcionalidades compartidas
│   ├── constants/        # Constantes de la aplicación
│   ├── failures/         # Manejo de errores
│   ├── mediator/         # Implementación del patrón Mediator
│   └── utils/            # Utilidades y validaciones
│
├── domain/               # Capa de Dominio (Lógica de Negocio)
│   ├── entities/         # Entidades de Isar (UserEntity, AddressEntity)
│   ├── models/           # Modelos de datos (UserModel, AddressModel)
│   ├── mappers/          # Conversión entre Entities y Models
│   └── repositories/     # Interfaces de repositorios
│
├── data/                 # Capa de Datos (Implementaciones)
│   └── repositories/     # Implementaciones de repositorios
│
├── features/             # Casos de Uso (CQRS)
│   └── user/
│       ├── commands/     # Comandos (CreateUserCommand)
│       ├── queries/      # Consultas (GetAllUsersQuery, GetUserByIdQuery)
│       └── handlers/     # Manejadores de Commands y Queries
│
└── presentation/         # Capa de Presentación
    ├── cubits/           # Gestión de estado (BLoC/Cubit)
    ├── screens/          # Pantallas de la aplicación
    ├── widgets/          # Widgets reutilizables
    ├── router/           # Navegación (GoRouter)
    └── di/               # Inyección de dependencias
```

### Flujo de Datos

1. **Presentation Layer** → El usuario interactúa con la UI
2. **Cubit** → Maneja el estado y envía Commands/Queries al Mediator
3. **Mediator** → Enruta la petición al Handler correspondiente
4. **Handler** → Ejecuta la lógica de negocio y llama al Repository
5. **Repository** → Interactúa con Isar para persistir/recuperar datos
6. **Mapper** → Convierte entre Entities (Isar) y Models (UI)

## 🎨 Patrones de Diseño

### 1. **Clean Architecture**

Separación en capas con dependencias unidireccionales hacia el dominio.

### 2. **CQRS (Command Query Responsibility Segregation)**

Separación de operaciones de lectura (Queries) y escritura (Commands):

**Commands (Escritura):**

```dart
class CreateUserCommand extends Request<Result<bool>> {
  final UserModel user;
  CreateUserCommand({required this.user});
}
```

**Queries (Lectura):**

```dart
class GetAllUsersQuery extends Request<Result<List<UserModel>>> {}
class GetUserByIdQuery extends Request<Result<UserModel>> {
  final int id;
  GetUserByIdQuery(this.id);
}
```

### 3. **Mediator Pattern**

Centraliza la comunicación entre componentes mediante un mediador:

```dart
class Mediator {
  Future<R> send<T extends Request<R>, R>(T request) async {
    final handler = getIt<RequestHandler<T, R>>();
    return await handler.handle(request);
  }
}
```

**Uso en Cubits:**

```dart
final result = await _mediator.send(GetAllUsersQuery());
final result = await _mediator.send(CreateUserCommand(user: user));
```

### 4. **Repository Pattern**

Abstracción de la capa de datos:

```dart
abstract class UserRepository {
  Future<Result<bool>> addUser(UserEntity user);
  Future<Result<List<UserEntity>>> getAllUsers();
  Future<Result<UserEntity?>> getUserById(int id);
}
```

### 5. **Dependency Injection (DI)**

Utiliza **GetIt** para inyección de dependencias:

```dart
// Registro de dependencias
getIt.registerSingleton<Isar>(isar);
getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(isar));
getIt.registerLazySingleton(() => Mediator());
getIt.registerLazySingleton<ListUserCubit>(() => ListUserCubit(getIt<Mediator>()));
```

### 6. **BLoC/Cubit Pattern**

Gestión de estado reactiva con **flutter_bloc**:

```dart
class ListUserCubit extends Cubit<ListUserState> {
  final Mediator _mediator;

  Future<void> getUsers() async {
    emit(state.copyWith(status: Status.loading));
    final result = await _mediator.send(GetAllUsersQuery());
    emit(state.copyWith(users: result.value, status: Status.loaded));
  }
}
```

### 7. **Builder Pattern**

Construcción de objetos complejos:

```dart
final user = UserModel.builder()
    .setName(state.name.value)
    .setLastName(state.lastName.value)
    .setBirthDate(state.birthDate.value)
    .addAddresses(state.addresses)
    .build();
```

### 8. **Mapper Pattern**

Conversión entre capas (Entity ↔ Model):

```dart
class UserMapper {
  static UserEntity toEntity(UserModel model) { ... }
  static UserModel toModel(UserEntity entity) { ... }
  static List<UserModel> toModelList(List<UserEntity> entities) { ... }
}
```

### 9. **Result Pattern**

Manejo de errores funcional:

```dart
class Result<T> {
  final T? value;
  final Failure? failure;

  factory Result.success(T value) => Result(value, null);
  factory Result.failure(Failure failure) => Result(null, failure);

  bool get isSuccess => value != null;
  bool get isFailure => failure != null;
}
```

## 💾 Base de Datos - Isar

### ¿Qué es Isar?

**Isar** es una base de datos NoSQL extremadamente rápida para Flutter y Dart. Es una alternativa moderna a Hive y SQLite, optimizada para aplicaciones móviles.

**Características principales:**

- 🚀 **Rendimiento**: Una de las bases de datos más rápidas para Flutter
- 🔍 **Queries potentes**: Soporte para filtros, ordenamiento y búsquedas complejas
- 📦 **Sin dependencias nativas**: Funciona en todas las plataformas
- 🔄 **Sincronización**: Soporte para observadores reactivos
- 🎯 **Type-safe**: Totalmente tipado con generación de código
- 🔧 **Inspector**: Herramienta de depuración integrada

### Configuración de Isar

#### 1. Dependencias en `pubspec.yaml`

```yaml
dependencies:
  isar: ^3.1.0+1
  isar_flutter_libs: ^3.1.0+1
  path_provider: ^2.1.5

dev_dependencies:
  isar_generator: ^3.1.0+1
  build_runner: ^2.4.11
```

#### 2. Definición de Entidades

Las entidades se definen con anotaciones de Isar:

```dart
import 'package:isar/isar.dart';

part 'user_entity.g.dart';

@Collection()
class UserEntity {
  @Index()
  Id? id = Isar.autoIncrement;  // ID auto-incremental
  String? name;
  DateTime? birthDate;
  String? lastName;
  List<AddressEntity> addresses = [];
}

@embedded
class AddressEntity {
  String? complement;
  String? city;
  String? country;
  String? department;
}
```

**Anotaciones importantes:**

- `@Collection()`: Define una colección (tabla) en Isar
- `@embedded`: Define un objeto embebido (no es una colección separada)
- `@Index()`: Crea un índice para búsquedas más rápidas
- `Id`: Tipo especial para el identificador único
- `Isar.autoIncrement`: Genera IDs automáticamente

#### 3. Generación de Código

Isar requiere generar código para las entidades:

```bash
flutter pub run build_runner build
# o para desarrollo continuo:
flutter pub run build_runner watch
```

Esto genera archivos `*.g.dart` con el código necesario.

#### 4. Inicialización de Isar

```dart
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

Future<void> setupInjection() async {
  // Obtener directorio de documentos
  final directory = await getApplicationDocumentsDirectory();

  // Abrir base de datos Isar
  final isar = await Isar.open(
    [UserEntitySchema],              // Esquemas a registrar
    directory: directory.path,       // Ruta de almacenamiento
    inspector: true,                 // Habilitar inspector (solo debug)
  );

  // Registrar en DI
  getIt.registerSingleton<Isar>(isar);
}
```

#### 5. Operaciones CRUD con Isar

**Crear/Actualizar (Write):**

```dart
Future<Result<bool>> addUser(UserEntity user) async {
  try {
    await isar.writeTxn(() async {
      await isar.userEntitys.put(user);  // put() crea o actualiza
    });
    return Result.success(true);
  } catch (e) {
    return Result.failure(DatabaseFailure(AppMessage.addUserError));
  }
}
```

**Leer todos (Read All):**

```dart
Future<Result<List<UserEntity>>> getAllUsers() async {
  final result = await isar.userEntitys.where().findAll();
  return Result.success(result);
}
```

**Leer por ID (Read by ID):**

```dart
Future<Result<UserEntity?>> getUserById(int id) async {
  final result = await isar.userEntitys
      .filter()
      .idEqualTo(id)
      .findFirst();
  return Result.success(result);
}
```

**Eliminar (Delete):**

```dart
Future<bool> deleteUser(int id) async {
  await isar.writeTxn(() async {
    await isar.userEntitys.delete(id);
  });
  return true;
}
```

#### 6. Isar Inspector

Isar incluye un inspector web para depuración:

```dart
final isar = await Isar.open(
  [UserEntitySchema],
  inspector: true,  // Habilitar inspector
);
```

Accede en: `http://localhost:8080` (cuando la app está corriendo en debug)

### Ventajas de Isar en este Proyecto

1. **Sin configuración compleja**: No requiere SQL ni migraciones complejas
2. **Type-safe**: Los errores se detectan en tiempo de compilación
3. **Rendimiento**: Operaciones extremadamente rápidas
4. **Relaciones embebidas**: `AddressEntity` se almacena dentro de `UserEntity`
5. **Inspector visual**: Facilita la depuración de datos

## 📦 Dependencias

### Dependencias de Producción

| Paquete                 | Versión  | Descripción                                 |
| ----------------------- | -------- | ------------------------------------------- |
| `flutter_bloc`          | ^9.1.1   | Gestión de estado con BLoC/Cubit            |
| `equatable`             | ^2.0.7   | Comparación de objetos para estados         |
| `get_it`                | ^8.2.0   | Inyección de dependencias (Service Locator) |
| `go_router`             | ^16.3.0  | Navegación declarativa                      |
| `isar`                  | ^3.1.0+1 | Base de datos NoSQL local                   |
| `isar_flutter_libs`     | ^3.1.0+1 | Librerías nativas de Isar para Flutter      |
| `path_provider`         | ^2.1.5   | Acceso a directorios del sistema            |
| `formz`                 | ^0.8.0   | Validación de formularios                   |
| `flex_color_scheme`     | ^8.3.0   | Temas de color personalizados               |
| `lottie`                | ^3.3.2   | Animaciones Lottie                          |
| `cherry_toast`          | ^1.13.0  | Notificaciones toast personalizadas         |
| `flutter_spinkit`       | ^5.2.2   | Indicadores de carga animados               |
| `remixicon`             | ^1.4.1   | Iconos Remix                                |
| `smooth_page_indicator` | ^1.2.1   | Indicadores de página suaves                |

### Dependencias de Desarrollo

| Paquete          | Versión  | Descripción                    |
| ---------------- | -------- | ------------------------------ |
| `build_runner`   | ^2.4.11  | Generación de código           |
| `isar_generator` | ^3.1.0+1 | Generador de código para Isar  |
| `flutter_lints`  | ^5.0.0   | Reglas de linting recomendadas |
| `mocktail`       | ^1.0.4   | Mocking para pruebas unitarias |

## 📁 Estructura del Proyecto

```
users_dvp_app/
├── android/                    # Configuración Android
├── ios/                        # Configuración iOS
├── assets/
│   └── animations/             # Animaciones Lottie
│       ├── detailUser.json
│       └── photoUser.json
├── lib/
│   ├── core/                   # Núcleo de la aplicación
│   │   ├── constants/          # Constantes y mensajes
│   │   ├── failures/           # Clases de error (Result Pattern)
│   │   ├── mediator/           # Implementación Mediator Pattern
│   │   ├── theme/              # Configuración de temas
│   │   └── utils/              # Utilidades y validaciones
│   │
│   ├── domain/                 # Capa de Dominio
│   │   ├── entities/           # Entidades Isar
│   │   │   ├── user_entity.dart
│   │   │   └── address_entity.dart
│   │   ├── models/             # Modelos de datos
│   │   │   ├── user_model.dart
│   │   │   └── address_model.dart
│   │   ├── mappers/            # Conversión Entity ↔ Model
│   │   │   ├── user_mapper.dart
│   │   │   └── address_mapper.dart
│   │   └── repositories/       # Interfaces de repositorios
│   │       └── user_repository.dart
│   │
│   ├── data/                   # Capa de Datos
│   │   └── repositories/
│   │       └── user_repository_impl.dart
│   │
│   ├── features/               # Casos de Uso (CQRS)
│   │   └── user/
│   │       ├── commands/       # Comandos de escritura
│   │       │   └── create_user_command.dart
│   │       ├── queries/        # Consultas de lectura
│   │       │   ├── get_all_users_query.dart
│   │       │   └── get_user_by_id_query.dart
│   │       └── handlers/       # Manejadores CQRS
│   │           ├── create_user_command_handler.dart
│   │           ├── get_all_users_query_handler.dart
│   │           └── get_user_by_id_query_handler.dart
│   │
│   └── presentation/           # Capa de Presentación
│       ├── cubits/             # Gestión de estado
│       │   ├── add_user/
│       │   ├── list_user/
│       │   └── detail_user/
│       ├── screens/            # Pantallas
│       ├── widgets/            # Widgets reutilizables
│       ├── router/             # Configuración de rutas
│       └── di/                 # Inyección de dependencias
│           └── inyection.dart
│
├── pubspec.yaml                # Configuración del proyecto
└── README.md                   # Este archivo
```

## 🚀 Instalación

### Prerrequisitos

- Flutter SDK 3.8.1 o superior
- Dart SDK 3.8.1 o superior
- Android Studio / Xcode (para desarrollo móvil)

## 💡 Uso

### Flujo de la Aplicación

1. **Listar Usuarios**: Pantalla principal que muestra todos los usuarios
2. **Agregar Usuario**: Formulario para crear nuevos usuarios con direcciones
3. **Detalle de Usuario**: Vista detallada de un usuario específico

### Ejemplo de Uso del Mediator

```dart
// En un Cubit
class ListUserCubit extends Cubit<ListUserState> {
  final Mediator _mediator;

  Future<void> getUsers() async {
    emit(state.copyWith(status: Status.loading));

    // Enviar query a través del mediator
    final result = await _mediator.send(GetAllUsersQuery());

    if (result.isFailure) {
      emit(state.copyWith(
        status: Status.failure,
        message: result.failure!.message
      ));
      return;
    }

    emit(state.copyWith(
      users: result.value,
      status: Status.loaded
    ));
  }
}
```

### Validación de Formularios con Formz

```dart
class NameInputValidation extends FormzInput<String, String> {
  const NameInputValidation.pure() : super.pure('');
  const NameInputValidation.dirty([String value = '']) : super.dirty(value);

  @override
  String? validator(String value) {
    if (value.isEmpty) return 'El nombre es requerido';
    if (value.length < 2) return 'El nombre debe tener al menos 2 caracteres';
    return null;
  }
}
```

## 🏆 Mejores Prácticas Implementadas

1. ✅ **Separación de responsabilidades** (Clean Architecture)
2. ✅ **SOLID Principles**
3. ✅ **Inyección de dependencias** (GetIt)
4. ✅ **Gestión de estado reactiva** (BLoC/Cubit)
5. ✅ **Manejo de errores funcional** (Result Pattern)
6. ✅ **Validación de formularios** (Formz)
7. ✅ **Type-safe database** (Isar)
8. ✅ **Navegación declarativa** (GoRouter)
9. ✅ **Código generado** (build_runner)
10. ✅ **Testing preparado** (mocktail)

## 📝 Notas Adicionales

- La aplicación soporta **modo claro y oscuro** automático
- Todas las operaciones de base de datos son **asíncronas**
- Los estados son **inmutables** gracias a Equatable
- La UI es **reactiva** y responde a cambios de estado
- El código está preparado para **testing unitario e integración**
