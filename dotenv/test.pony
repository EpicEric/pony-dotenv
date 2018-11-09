use "ponytest"

actor Main is TestList
  new create(env: Env) =>
    PonyTest(env, this)

  fun tag tests(test: PonyTest) =>
    ifdef debug then
      test(_TestDevDifferentEnv)
      test(_TestDevChangeVars)
      test(_TestDevDontChangeOtherParams)
    else
      test(_TestProdSameEnv)
    end

class iso _TestProdSameEnv is UnitTest
  fun name(): String => "prod/Return same env"

  fun apply(h: TestHelper) =>
    let env: Env = h.env
    let dotenv: Env = Dotenv(env)
    h.assert_is[Env](env, dotenv)

class iso _TestDevDifferentEnv is UnitTest
  fun name(): String => "dev/Return different env"

  fun apply(h: TestHelper) =>
    let env: Env = h.env
    let dotenv: Env = Dotenv(env)
    h.assert_isnt[Env](env, dotenv)

class iso _TestDevChangeVars is UnitTest
  fun name(): String => "dev/New env changes vars"

  fun apply(h: TestHelper) =>
    let env: Env = h.env
    let dotenv: Env = Dotenv(env)
    h.assert_isnt[Array[String] val](env.vars, dotenv.vars)

class iso _TestDevDontChangeOtherParams is UnitTest
  fun name(): String => "dev/New env doesnt change other params"

  fun apply(h: TestHelper) =>
    let env: Env = h.env
    let dotenv: Env = Dotenv(env)
    h.assert_is[(AmbientAuth | None)](env.root, dotenv.root)
    h.assert_is[InputStream](env.input, dotenv.input)
    h.assert_is[OutStream](env.out, dotenv.out)
    h.assert_is[OutStream](env.err, dotenv.err)
    h.assert_is[Array[String] val](env.args, dotenv.args)
    h.assert_is[{(I32)} val](env.exitcode, dotenv.exitcode)
