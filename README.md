### Setup Project
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
- [x] pre-commit black, isort
- [ ] data gen

Other:
- [ ] ci/cd with github actions


Terraform:

ref https://gmusumeci.medium.com/how-to-create-a-service-account-for-terraform-in-gcp-google-cloud-platform-f75a0cf918d1

- [x] mkdir infra
- [x] gcloud config set project pipeline-374517
- [x] gcloud iam service-accounts create terraform
- [x] grant editor role using gcloud
- [x] enable Identity and Access Management (IAM) API
- [x] enable Cloud Resource Manager API
- [x] enable Cloud Billing API
- [x] asdf install terraform
- [x] airflow service account
- [ ] admin service account
- [ ] composer
- [x] staging dataset
- [ ] curated dataset
- [ ] staging bucket - bq external tables? Files?

Data:
- [x] generation script
- [x] gen raw files

## Issues
- [ ] don't want profiles in source due to passwords?
- [ ] uninstall incorrectly added packages with dbt deps?


* Data dir contains package for genersting data
* Infra dir is for terraform
* Pipeline dir contains dbt project

