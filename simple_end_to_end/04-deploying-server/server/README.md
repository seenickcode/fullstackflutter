# server

## Deploying

2. Sign up for Google Cloud Platform.
3. Create a project, enable billing.
1. Get `docker`, `gcloud` CLI tool (["Google Cloud SDK"](https://cloud.google.com/sdk/docs/install)). (Ensure you run `gcloud init`) to authenticate with your GCP account. Then run `gcloud auth configure-docker` so you can [push images](https://cloud.google.com/container-registry/docs/pushing-and-pulling).
4. Enable GCP Container Registry (search for it in the GCP console at `console.cloud.google.com`).
5. Build your docker image using the canonical naming convention `gcr.io/<my project ID>/<my repository name>:<version>`, such as `gcr.io/foobar-123/simple_end_to_end:v0.1`. If you do this and push the image, the GCP Container Registry Repository will automatically be created for you. So from this directory, run: `docker build -t gcr.io/<my project ID>/<my repository name>:<version> .`. (Don't forget the `.` character at the end)
6. Test your image by running it: `docker run --rm -it -p 8888 gcr.io/<my project ID>/<my repository name>:<version>`
6. Push your image `docker push gcr.io/<my project ID>/<my repository name>:<version>`
7. Deploy your image to Google Cloud Run. Either click on '...' icon on your image version in GCP Container Registry and choose "Deploy with Google Cloud Run" or run the command: `gcloud run deploy simple-e2e --image gcr.io/<my project ID>/<my repository name>:<version>`. Choose option 1, `[1] Cloud Run (fully managed)`.

## Warning

This project requires a specific version of Aquduct! Please use this command to install the correct version.

`pub global activate aqueduct 4.0.0-b1`

## How We Set this Project Up

1. `aqueduct create <project name, snake case>`

2. Note, installing a database is NOT required for this example!

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
