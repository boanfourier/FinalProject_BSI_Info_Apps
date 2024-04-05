import 'package:bsi_info_apps/domain/entities/user.dart';
import 'package:bsi_info_apps/data/repository/user_repository.dart';

class Login {
  var repository = UserRepository();

  Future<User> execute(User user) {
    return repository.login(user); // Changed User to user
  }
}
