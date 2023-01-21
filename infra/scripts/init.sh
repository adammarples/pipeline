# init the service accounts for terraform to do the rest

PROJECT=$1  # pipeline-374517
SA=terraform
EMAIL=$SA@$PROJECT.iam.gserviceaccount.com
CREDS=/Users/adammarples/.secrets/$EMAIL.json

gcloud config set project $PROJECT
gcloud iam service-accounts create $SA
gcloud iam service-accounts add-iam-policy-binding $EMAIL --role=roles/editor --member='allAuthenticatedUsers'
gcloud iam service-accounts add-iam-policy-binding $EMAIL --role=roles/iam.serviceAccountAdmin --member='allAuthenticatedUsers'
gcloud iam service-accounts keys create $CREDS --iam-account=$EMAIL

cd .. && terraform init && terraform plan
echo "run terraform apply if happy"
