# Katalog

A data catalog and credentials manager powered by Kubernetes resources:
- [`Asset`](docs/README.md#asset) CRD for managing data assets
- `Secret` resources for managing data access credentials

## Usage

See [documentation](https://mesh-for-data.github.io/mesh-for-data/latest/reference/katalog/) in the website.

## Develop, Build and Deploy

The source of the `Asset` CRD are the files in the [`manifests`](manifests) directory. After modifying them run `make generate`.

Build and push the connector image with `make all` (cleanup with `make clean`).

Install with Helm as part of the standard Mesh for Data installation:
- [m4d-crd](https://github.com/mesh-for-data/mesh-for-data/tree/master/charts/m4d-crd) Helm chart 
  ```
  helm install m4d-crd charts/m4d-crd
  ```
- [m4d](https://github.com/mesh-for-data/mesh-for-data/tree/master/charts/m4d) Helm chart with `katalogConnector.enabled=true` (default).
  ```
  helm install m4d charts/m4d-crd
  ```

## Where is this going?

The current `Asset` specification was directly imported from the existing connectors API (the proto definitions) without any thought of whether this specification is the right one to use. Moving forward the entire connectors API should be refined to avoid hardcoding and all structures should be reviewed.

The plan is to experiment and check if OpenAPI 3.0 documents can be used as the core mechanism for taxonomies in Mesh for Data. The role of Katalog is to be a catalog and credentials connector that is auto generated from a reference taxonomy. The work on taxonomies is in very early stages, see https://github.com/mesh-for-data/mesh-for-data/issues/238.

