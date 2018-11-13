trait DotEnvSample
  new val create()

  fun apply(): String

primitive DotEnvSample1 is DotEnvSample
  new create() =>
    None

  fun apply(): String =>
    "HELLO=world"
