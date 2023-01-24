# init the service accounts for terraform to do the rest

PROJECT=$1  # pipeline-374517
SA=terraform
EMAIL=$SA@$PROJECT.iam.gserviceaccount.com
CREDS=/Users/adammarples/.secrets/$EMAIL.json

gcloud config set project $PROJECT
gcloud iam service-accounts create $SA
gcloud projects add-iam-policy-binding $PROJECT --member serviceAccount:$EMAIL --role roles/owner
gcloud iam service-accounts keys create $CREDS --iam-account=$EMAIL



cd .. && terraform init && terraform plan
echo "run terraform apply [-auto-approve] if happy"
