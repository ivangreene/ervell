#
# Using ["The Twelve-Factor App"](http://12factor.net/) as a reference all
# environment configuration will live in environment variables. This file
# simply lays out all of those environment variables with sensible defaults
# for development.
#

module.exports =

  NODE_ENV: "development"
  PORT: 4000
  # last one is the "rotten egg", jk last one listed is the one used.
  API_URL: "http://staging.are.na/v2"
  #API_URL: "http://arenaprototyperefactorb843.ninefold-apps.com/v3"
  #API_URL: "http://localhost:3000/v3"

# Override any values with env variables if they exist
module.exports[key] = (process.env[key] or val) for key, val of module.exports
