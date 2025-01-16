import '../../../domain/entities/user_entity.dart';
import '../../models/app_user/app_user.dart';

class UserMapper {
  static UserEntity toEntity(AppUser appUser) {
    return UserEntity(
      id: appUser.userID,
      name: appUser.name,
      email: appUser.email,
      books: appUser.books,
    );
  }

  static AppUser fromEntity(UserEntity userEntity) {
    return AppUser(
      userID: userEntity.id,
      name: userEntity.name,
      email: userEntity.email,
      books: userEntity.books,
    );
  }
}