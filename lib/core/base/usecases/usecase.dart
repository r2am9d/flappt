abstract class UseCase<T, P> {
  Future<T> execute(P params);
}

class NoParams {
  const NoParams();
}
