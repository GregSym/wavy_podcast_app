class NullChecks {
  static T checkFunction<T>(Function func) => func() == null ? false : func();
}
