docker login -u="quentin_gense+titanic" -p="QQJ0J9FVZD6KAAFWZ8KDL3J3L9V8F25R4UTBGX646XYAA8DC5L47G7E7C0XHJJ1O" quay.io # <--- mettez ici les informations de votre robot quay.io
kubectl config set-cluster openshift-cluster --server=https://api.rm1.0a51.p1.openshiftapps.com:6443 # <--- mettez ici l'url de votre cluster OpenShift
kubectl config set-credentials openshift-credentials --token=secrets.xpibWfW4Vhk7mRDvjizV6prscEnOdPPICmoNwG8Yaqg # <--- mettez ici le token d'accès à votre cluster OpenShift
kubectl config set-context openshift-context --cluster=openshift-cluster --user=openshift-credentials --namespace=vars.quentin-gense-dev # <--- mettez ici votre namespace OpenShift
kubectl config use openshift-context

export KUBE_MLFLOW_TRACKING_URI=https://mlflow-quentin-gense-dev.apps.0a51.openshiftapps.com # <--- mettez ici l'url de votre service mlflow
export MLFLOW_TRACKING_URI=https://mlflow-quentin-gense-dev.apps.0a51.openshiftapps.com # <--- mettez ici l'url de votre service mlflow
export MLFLOW_S3_ENDPOINT_URL=https://minio-api-quentin-gense-dev.apps.0a51.openshiftapps.com # <--- mettez ici l'url de votre service minio
export AWS_ACCESS_KEY_ID=minio
export AWS_SECRET_ACCESS_KEY=minio123

# Renseignez bien dans la ligne ci-dessous le tag de l'image que vous souhaitez construire (repository quay.io créé au préalable)
docker build -f ./k8s/experiment/Dockerfile -t quay.io/quentin_gense/titanic/experiment:latest --build-arg MLFLOW_S3_ENDPOINT_URL=$MINIO_API_ROUTE_URL --build-arg AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID--build-arg AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY ..

uv run mlflow run ../src/titanic/training -P path=all_titanic.csv --experiment-name kto-titanic --backend kubernetes --backend-config ../k8s/experiment/kubernetes_config.json
