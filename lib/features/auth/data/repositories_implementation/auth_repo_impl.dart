
import 'package:flower_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:flower_app/features/auth/domain/repositories/Auth_repo.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {

  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRepoImpl(this._authRemoteDatasource);

}