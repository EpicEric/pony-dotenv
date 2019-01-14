use "files"

primitive DotEnv
  fun apply(e: Env): Env =>
    ifdef debug then
      try
        let new_vars: Array[String] iso =
          _vars_from_dotenv(e.root as AmbientAuth)?
        let vars: Array[String] iso = _join_vars(e.vars, consume new_vars)
        Env(e.root, e.input, e.out, e.err, e.args, consume vars, e.exitcode)
      else e end
    else e end

  fun _vars_from_dotenv(auth: AmbientAuth): Array[String] iso^ ? =>
    """
    Read vars from a .env file in cwd.
    """
    let path = ".env"
    let filepath = FilePath(auth, path)?
    let vars: Array[String] iso = recover Array[String] end
    with file = OpenFile(filepath) as File do
      for line in FileLines(file) do
        if line.size() > 0 then
          vars.push(consume line)
        end
      end
    end
    consume vars

  fun _join_vars(
    old_vars: Array[String] box, new_vars: Array[String] box
  ): Array[String] iso^ =>
    let vars: Array[String] iso = recover Array[String] end
    for v in new_vars.values() do
      vars.push(v)
    end
    for v in old_vars.values() do
      vars.push(v)
    end
    consume vars
