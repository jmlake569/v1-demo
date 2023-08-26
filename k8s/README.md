# K8s Demo

## Deploy Demo

- Deploy the demo application;
```bash
terraform init
terraform plan
terraform apply -auto-approve
```

## Run the attacks

- Run the attacks by executing the scripts/attack.sh script, the script is interactive and will ask you which attack you want to run;

## Results

- Check the Vision One events and workbenches;


## Destroy Demo

- Destroy the demo application;
```bash
kubectl delete -f deployments/java-goof.yaml
```

PS.: You MUST delete the java-goof deployment before destroy the environment (terraform destroy) or you will get an error. The reason is that the deployment create a ELB and a SG that the vpc module does not own.

- Destroy the demo application;
```bash
terraform destroy -auto-approve
```











