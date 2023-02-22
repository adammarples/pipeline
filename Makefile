terraform-apply:
	cd terraform/prod; \
	terraform apply -auto-approve

dbt-run:
	cd pipeline; \
	dbt run --profiles-dir=../.dbt

dbt-build:
	cd pipeline; \
	dbt build --profiles-dir=../.dbt

dbt-test-sources:
	cd pipeline; \
	dbt test --select source:* --profiles-dir=../.dbt

refresh-raw:
	cd data && \
	gsutil -m rm gs://pipeline-374517-raw/**
	gsutil -m cp ./data/raw/**/*.csv  gs://pipeline-374517-raw/

credentials-refresh:
	gcloud iam service-accounts keys create ${SECRETS}/orchestrator@${PROJECT}.iam.gserviceaccount.com.json --iam-account=orchestrator@${PROJECT}.iam.gserviceaccount.com.json
