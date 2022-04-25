import Config

# Configure your database
config :huzzah, Huzzah.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "huzzah_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with esbuild to bundle .js and .css sources.
config :huzzah, HuzzahWeb.Endpoint,
  https: [
    ip: {0, 0, 0, 0},
    port: 4000,
    cipher_suite: :strong,
    certfile: "priv/cert/dev.crt",
    keyfile: "priv/cert/dev.key"
  ],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "m8a0lgOpcXhNckj3iw3UW1uhh/Mtqka3DLuVFh2SLw9ZedVOQLD5TbNG+Sq29NUa",
  watchers: []

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :cors_plug,
  origin: ["https://localhost:3000"],
  max_age: 86_400,
  methods: ["POST"]
