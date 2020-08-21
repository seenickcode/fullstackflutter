# oauth

NOTE: requires aqueduct 4.0.0-b1 or later.

## Installation

1. `pub global activate aqueduct 4.0.0-b1`
2. `pub get`
3. Install and start Postgres. Create a database called `oauth`
4. Run the Aqueduct migrations which will create the schema (edit username and password here as needed): `aqueduct db upgrade --connect postgres://postgres:1234@localhost:5432/oauth`


## Demo

1. Create an oauth client entry in the database: `aqueduct auth add-client --id dev.nickmanning --redirect-uri https://google.com --connect postgres://postgres:1234@localhost:5432/oauth` (more info [here](https://aqueduct.io/docs/auth/cli/))

2. `aqueduct serve` (or in VSCode, bin/main.dart and click Run or Debug)
3. Register a user

```
curl -X POST http://localhost:8888/register \
  -H 'Content-Type: application/json' \
  -d '{"username":"bob6", "password":"password"}'
```

4. Simulate   

4. Generate an authorization header via: `printf 'dev.nickmanning:' | base64`. Warning: using `echo` adds a new line character which will not work! `printf` prevents this. Also, note that we have the `:` here as we are not using a client secret.

```

curl -v http://localhost:8888/protected \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Bearer xqe3NjsZ54gDZlkeX2ag7RQohkDppPeR'



curl -X POST http://localhost:8888/auth/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic ZGV2Lm5pY2ttYW5uaW5nOjEyMzQK' \
  -d 'grant_type=refresh_token&refresh_token=d7ScKn1yIo8DouM2qGoI7gmde01ATf46&scopes=*'





curl -X POST http://localhost:8888/auth/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic ZGV2Lm5pY2ttYW5uaW5nOg==' \
  -d 'grant_type=refresh_token'

curl -X POST http://localhost:8888/auth/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic ZGV2Lm5pY2ttYW5uaW5nOg==' \
  -d 'username=bob6&password=password&grant_type=password'





curl -v http://localhost:8888/protected \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Bearer 2kCdHmfAKEKrDRcKA4jeWK44drm6k7M'

curl -X POST http://localhost:8888/auth/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic ZGV2Lm5pY2ttYW5uaW5nOg==' \
  -d 'grant_type=refresh_token&refresh_token=kjasdiuz9u3namnsd'

```


## Recommended VSCode Extensions

If you're using VSCode:

* "Pubspec Assist" by Jeroen Meijer
* VSCode settings:

```
"dart.debugExternalLibraries": true,
"dart.debugSdkLibraries": true
```

## Gotchas

* Don't use `echo` to generate base64 encoded values, use `printf`

## Running the Application Locally

Run `aqueduct serve` from this directory to run the application. For running within an IDE, run `bin/main.dart`. By default, a configuration file named `config.yaml` will be used.

To generate a SwaggerUI client, run `aqueduct document client`.

## Trying Things Out

1. Start the server `aqueduct serve`
2. Create a user: `curl -X POST http://localhost:8888/register -H 'Content-Type: application/json' -d '{"username":"bob", "password":"password"}'`

## Running Application Tests

To run all tests for this application, run the following in this directory:

```
pub run test
```

The default configuration file used when testing is `config.src.yaml`. This file should be checked into version control. It also the template for configuration files used in deployment.

## Deploying an Application

See the documentation for [Deployment](https://aqueduct.io/docs/deploy/).