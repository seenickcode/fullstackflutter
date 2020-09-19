# server

## Warning

This project requires a specific version of Aquduct! Please use this command to install the correct version.

`pub global activate aqueduct 4.0.0-b1`

## How We Set this Project Up

1. `aqueduct create <project name, snake case>`

2. Note, installing a database is NOT required for this example!

## Next Steps

1. Covering Postgres

## Running the Application Locally

Run `aqueduct serve` from this directory to run the application. For running within an IDE, run `bin/main.dart`. By default, a configuration file named `config.yaml` will be used.

To generate a SwaggerUI client, run `aqueduct document client`.

## Running Application Tests

To run all tests for this application, run the following in this directory:

```
pub run test
```

The default configuration file used when testing is `config.src.yaml`. This file should be checked into version control. It also the template for configuration files used in deployment.

## Deploying an Application

See the documentation for [Deployment](https://aqueduct.io/docs/deploy/).
