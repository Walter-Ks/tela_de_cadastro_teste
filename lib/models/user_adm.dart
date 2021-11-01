import 'package:aula_01/models/user-abstract.dart';
import 'package:aula_01/models/user_trainer.dart';

class UserAdm extends AbstractUser {
  late String gymName;
  late String gymLogo;
  late List<int> listTrainerIds;
  late List<UserTrainer> listUserTrainer;
}
