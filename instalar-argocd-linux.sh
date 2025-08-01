#!/bin/bash

set -e

echo "🚀 Instalando Kubernetes leve (K3s)..."
curl -sfL https://get.k3s.io | sh -

export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> ~/.bashrc

echo "✅ Kubernetes instalado com sucesso!"
kubectl get nodes

echo "📦 Instalando Argo CD no namespace 'argocd'..."
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo "⏳ Aguardando os pods do Argo CD ficarem prontos..."
kubectl wait --for=condition=available --timeout=180s deployment/argocd-server -n argocd

echo "🔐 Recuperando senha inicial do admin..."
echo -n "Senha: "
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d && echo

echo "🌐 Expondo o Argo CD na porta 8080 via port-forward..."
echo "Use: kubectl port-forward svc/argocd-server -n argocd 8080:443"
