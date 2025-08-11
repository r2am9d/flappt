abstract class Usecase<T, P> {
  Future<T> execute(P params);
}

class NoParams {
  const NoParams();
}
