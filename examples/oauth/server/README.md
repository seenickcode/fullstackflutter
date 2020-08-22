# oauth

NOTE: requires aqueduct 4.0.0-b1 or later.

## Installation

1. `pub global activate aqueduct 4.0.0-b1`
2. `pub get`
3. Install and start Postgres. Create a database called `oauth`
4. Run the Aqueduct migrations which will create the schema (edit username and password here as needed): `aqueduct db upgrade --connect postgres://postgres:1234@localhost:5432/oauth`

## Demo

1. Create an oauth client entry in the database: `aqueduct auth add-client --id dev.nickmanning --secret '1234' --redirect-uri oauth://exchange --connect postgres://postgres:1234@localhost:5432/oauth` (more info [here](https://aqueduct.io/docs/auth/cli/))

Gotcha: `--secret ''` must be used or else the `_authclient` table's `hashedsecret` column will be set to null. When fetching an auth code, an error will be returned as this is expected to not be null.

2. `aqueduct serve` (or in VSCode, bin/main.dart and click Run or Debug)
3. Register a user

```
curl -X POST http://localhost:8888/register \
  -H 'Content-Type: application/json' \
  -d '{"username":"bob8", "password":"password"}'
```

4. Simulate

5. Generate an authorization header via: `printf 'dev.nickmanning:1234' | base64`. Warning: using `echo` adds a new line character which will not work! `printf` prevents this. Also, note that we have the `:` here as we are not using a client secret.

6. We can now either POST to `/auth/code` to get a code or navigate to `/auth/code` to get a webpage folks can use to authenticate. In either
   situation, the username and password is submitted, along with the client ID we used to register.

Note: `state` here is used when requesting an auth code but also is included in the redirect response query string. The client is supposed to verify this value matches.

```
curl -v -X POST http://localhost:8888/auth/code \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic ZGV2Lm5pY2ttYW5uaW5nOjEyMzQ=' \
  -d 'response_type=code&client_id=dev.nickmanning&state=1234&username=bob7&password=password'
```

The server will respond with a redirect via 302 HTTP code and `location` in the repsonse header in this format: `<your redirect URI>?code=<auth code>&state=<your state value>`. This is why we use `-v` in the curl example above, so that we can see the value of `location`.

OR we can go to http://localhost:8888/auth/code?response_type=code&client_id=dev.nickmanning&state=1234
to login and get a code.

6. Now we can request an auth token using our `code` value:

```
curl -X POST http://localhost:8888/auth/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic ZGV2Lm5pY2ttYW5uaW5nOjEyMzQ=' \
  -d 'grant_type=authorization_code&code=2Ux5NSWFuw28FgaHXnFUHwTiTQ7Yl0zw'
```

7. Now we can access our protected resource

```
curl -v http://localhost:8888/protected \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Bearer PWkkbxEZzzlX7WdzVYwV1zyBtdbG9CoU'
```

8. Our OAuth client can refresh the auth token now via

```
curl -X POST http://localhost:8888/auth/token \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -H 'Authorization: Basic ZGV2Lm5pY2ttYW5uaW5nOjEyMzQ=' \
  -d 'grant_type=refresh_token&refresh_token=kcjQKMQfHYYnrsS9T6E9DkypMVt7mhCc'
```

9. Optional: we can call our /protected route above with the previously used stale
   token and we'll get a 401 unauthorized.

## Recommended VSCode Extensions

If you're using VSCode:

- "Pubspec Assist" by Jeroen Meijer
- VSCode settings:

```
"dart.debugExternalLibraries": true,
"dart.debugSdkLibraries": true
```

## Gotchas

- Don't use `echo` to generate base64 encoded values, use `printf`

## Running the Application Locally

Run `aqueduct serve` from this directory to run the application. For running within an IDE, run `bin/main.dart`. By default, a configuration file named `config.yaml` will be used.

To generate a SwaggerUI client, run `aqueduct document client`.

## TODO List

- Auth code + PKCE support (not supported in Aqueduct at the moment)
- Ability to use Auth code flow without a `client_secret` (we have to hard code it in our examples)
