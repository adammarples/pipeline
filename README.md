### Setup Project
Python and Git:
- [x] create README.md
- [x] put python 3.10 and direnv into .tool-versions
- [x] create .envrc with use asdf
- [x] create .gitignore with above
- [x] create git init
- [x] asdf build the python version
- [x] check direnv switches to correct version

Dbt:
- [x] pip install dbt-biquery
- [x] add packages.yaml to pipeline dir
- [x] add dbt-vault to packages
- [x] cd pipeline and install with dbt deps
- [ ] triggers on write...?
- [x] script to drop data

Other:
- [x] pre-commit black, isort
- [x] data gen
- [ ] ci/cd with github actions
- [ ] add data compression


Terraform:

ref https://gmusumeci.medium.com/how-to-create-a-service-account-for-terraform-in-gcp-google-cloud-platform-f75a0cf918d1

- [x] mkdir infra
- [x] gcloud config set project pipeline-374517
- [x] gcloud iam service-accounts create terraform
- [x] grant owner role using gcloud
- [x] enable Identity and Access Management (IAM) API
- [x] enable Cloud Resource Manager API
- [x] enable Cloud Billing API
- [x] asdf install terraform
- [x] airflow service account and fetch key (gcloud iam service-accounts keys create $CREDS --iam-account=$EMAIL)
- [x] create a role for orchestrator/dbt and fill it with bq permissions
- [ ] admin service account
- [ ] composer
- [x] staging dataset
- [x] staging bucket - bq external tables

Data:
- [x] generation script
- [x] gen raw files

## Issues
- [ ] don't want profiles in source?
- [x] uninstall incorrectly added packages with dbt deps?
- [ ] can't use _FILE_NAME in dbt-vault stg tables

* Data dir contains package for generating data
* Infra dir is for terraform
* Pipeline dir contains dbt project

