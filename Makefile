terraform-apply:
	cd terraform/prod && \
	terraform apply -auto-approve

dbt-run:
	cd pipeline && \
	dbt run --profiles-dir=../.dbt

credentials-refresh:
	gcloud iam service-accounts keys create /Users/adammarples/.secrets/orchestrator@pipeline-374517.iam.gserviceaccount.com.json --iam-account=orchestrator@pipeline-374517.iam.gserviceaccount.com.json
