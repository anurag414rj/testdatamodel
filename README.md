# testdatamodel

Sigma data model managed as code. Specs live in `specs/` and are pushed through the
`/v2/dataModels` REST API.

## Setup

```bash
cp .env.example .env   # fill in SIGMA_BASE_URL, SIGMA_CLIENT_ID, SIGMA_CLIENT_SECRET
```

Requires `curl` and `jq`.

## Usage

```bash
scripts/sigma.sh get-spec <dataModelId> > specs/model.json   # export an existing model
scripts/sigma.sh post specs/model.json                       # create
scripts/sigma.sh put <dataModelId> specs/model.json          # update (full spec required)
```

Notes: create and update both take the full spec (no partial updates); IDs are remapped on
create and preserved on update.
