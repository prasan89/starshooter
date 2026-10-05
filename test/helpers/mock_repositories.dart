import 'package:mocktail/mocktail.dart';
import 'package:star_shooter/domain/repositories/entitlement_repository.dart';
import 'package:star_shooter/domain/repositories/level_repository.dart';
import 'package:star_shooter/domain/repositories/player_repository.dart';

/// Mock implementation of [LevelRepository] for use in unit and widget tests.
class MockLevelRepository extends Mock implements LevelRepository {}

/// Mock implementation of [PlayerRepository] for use in unit and widget tests.
class MockPlayerRepository extends Mock implements PlayerRepository {}

/// Mock implementation of [EntitlementRepository] for use in unit and widget tests.
class MockEntitlementRepository extends Mock implements EntitlementRepository {}
