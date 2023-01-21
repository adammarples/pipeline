# init the service accounts for terraform to do the rest

PROJECT=$1  # pipeline-374517
SA=terraform

gcloud config set project $PROJECT
gcloud iam service-accounts create $SA
gcloud iam service-accounts add-iam-policy-binding $SA@$PROJECT.iam.gserviceaccount.com \
  --role=roles/editor --member='allAuthenticatedUsers'
