abstract class Failure {
  final String message;
  const Failure(this.message);
}
class ServerFailure  extends Failure { const ServerFailure(super.message); }
class NetworkFailure extends Failure { const NetworkFailure(super.message); }
class AuthFailure    extends Failure { const AuthFailure(super.message); }
class AIFailure      extends Failure { const AIFailure(super.message); }
