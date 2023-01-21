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
- [ ] ci/cd with github actions
- [ ] pre-commit black, isort
- [ ] data gen

Terraform:
- [x] mkdir infra
- [x] gcloud config set project pipeline-374517
- [x] gcloud iam service-accounts create terraform
- [ ] grant editor role using gcloud
- [x] asdf install terraform
- [ ] airflow service account
- [ ] admin service account
- [ ] composer
- [ ] staging dataset
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

