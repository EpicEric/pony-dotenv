use "files"

primitive DotEnv
  fun apply(e: Env): Env =>
    ifdef debug then
      try
        let vars: Array[String] iso = _vars_from_dotenv(e.root as AmbientAuth)?
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
