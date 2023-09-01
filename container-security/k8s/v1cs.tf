resource "null_resource" "deploy_v1cs" {
  depends_on = [
    module.eks
  ]
  provisioner "local-exec" {
    command = <<-EOT

    # Add cluster to kubeconfig
    aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)

    # Create necessary namespaces
    kubectl create namespace tigera-operator
    kubectl create namespace demo
    kubectl create namespace attacker

    # Install Calico
    helm install calico projectcalico/tigera-operator -f deployments/values.yaml --namespace tigera-operator

    # Deploy java-goof
    kubectl apply -f deployments/java-goof.yaml

    # Install Vision One Container Security
    helm install \
    --values deployments/overrides.yaml \
    --namespace "trendmicro-system" \
    --create-namespace \
    trendmicro \
    https://github.com/trendmicro/cloudone-container-security-helm/archive/master.tar.gz

    EOT
  }
}
