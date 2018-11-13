use "files"
use "ponytest"
use ".."

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    ifdef debug then
      test(_TestDevSameEnvNoFile)
      test(_TestDevDifferentEnvWithFile)
      test(_TestDevChangeVars)
      test(_TestDevDontChangeOtherParams)
    else
      test(_TestProdSameEnv)
    end

trait _DotEnvUnitTest[A: DotEnvSample] is UnitTest
  """
  Helper trait to implement .env file setup/teardown for unit tests.

  The generic type specifies which .env sample text to use.
  """
  fun ref set_up(h: TestHelper) ? =>
    let auth = h.env.root as AmbientAuth
    let path = ".env"
    let filepath = FilePath(auth, path)?
    with file = CreateFile(filepath) as File do
      if not file.write(A()) then error end
    end

  fun ref tear_down(h: TestHelper) =>
    try
      let auth = h.env.root as AmbientAuth
      let path = ".env"
      FilePath(auth, path)?.remove()
    end

class iso _TestProdSameEnv is _DotEnvUnitTest[DotEnvSample1]
  fun name(): String => "prod/Return same env"

  fun apply(h: TestHelper) =>
    let env: Env = h.env
    let dotenv: Env = DotEnv(env)
    h.assert_is[Env](env, dotenv)

class iso _TestDevSameEnvNoFile is UnitTest
  fun name(): String => "dev/Return same env if .env is missing"

  fun apply(h: TestHelper) =>
    let env: Env = h.env
    let dotenv: Env = DotEnv(env)
    h.assert_is[Env](env, dotenv)

class iso _TestDevDifferentEnvWithFile is _DotEnvUnitTest[DotEnvSample1]
  fun name(): String => "dev/Return different env if .env is present"

  fun apply(h: TestHelper) =>
    let env: Env = h.env
    let dotenv: Env = DotEnv(env)
    h.assert_isnt[Env](env, dotenv)

class iso _TestDevChangeVars is _DotEnvUnitTest[DotEnvSample1]
  fun name(): String => "dev/New env instantiates new vars"

  fun apply(h: TestHelper) =>
    let env: Env = h.env
    let dotenv: Env = DotEnv(env)
    h.assert_isnt[Array[String] val](env.vars, dotenv.vars)

class iso _TestDevDontChangeOtherParams is _DotEnvUnitTest[DotEnvSample1]
  fun name(): String => "dev/New env doesnt change other params"

  fun apply(h: TestHelper) =>
    let env: Env = h.env
    let dotenv: Env = DotEnv(env)
    h.assert_is[(AmbientAuth | None)](env.root, dotenv.root)
    h.assert_is[InputStream](env.input, dotenv.input)
    h.assert_is[OutStream](env.out, dotenv.out)
    h.assert_is[OutStream](env.err, dotenv.err)
    h.assert_is[Array[String] val](env.args, dotenv.args)
    h.assert_is[{(I32)} val](env.exitcode, dotenv.exitcode)
