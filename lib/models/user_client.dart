import 'package:aula_01/models/training_block.dart';
import 'package:aula_01/models/user-abstract.dart';

class UserClient extends AbstractUser {
  late String uniqueCodeClient;
  late List<TrainingBlock> listTrainingBlocks;
}
