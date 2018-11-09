primitive Dotenv
  fun apply(e: Env): Env =>
    ifdef debug then
      let vars: Array[String] iso = recover Array[String] end
      Env(e.root, e.input, e.out, e.err, e.args, consume vars, e.exitcode)
    else e end
