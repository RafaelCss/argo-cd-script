
# Verifica se o kubectl está instalado
if (-not (Get-Command kubectl -ErrorAction SilentlyContinue)) {
    Write-Host "kubectl não encontrado. Instale o Kubernetes via Docker Desktop e tente novamente." -ForegroundColor Red
    exit 1
}

# Cria o namespace argocd
kubectl create namespace argocd

# Instala o Argo CD via manifest oficial
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

Write-Host "Aguardando pods do Argo CD ficarem prontos..." -ForegroundColor Cyan

# Espera os pods ficarem prontos (timeout de 180s)
$timeout = 180
$elapsed = 0
do {
    Start-Sleep -Seconds 5
    $allReady = kubectl get pods -n argocd | Select-String -NotMatch "Pending|ContainerCreating|Error"
    $readyCount = ($allReady | Measure-Object).Count
    $totalCount = (kubectl get pods -n argocd --no-headers | Measure-Object).Count

    $elapsed += 5
    Write-Host "[$elapsed s] Verificando pods... $readyCount / $totalCount prontos"
} while ($readyCount -lt $totalCount -and $elapsed -lt $timeout)

if ($readyCount -lt $totalCount) {
    Write-Host "Alguns pods não estão prontos. Verifique com: kubectl get pods -n argocd" -ForegroundColor Yellow
    exit 1
}

# Faz o port-forward para localhost:8080
Write-Host "Iniciando Argo CD em https://localhost:8080" -ForegroundColor Green
Start-Process powershell -ArgumentList "kubectl port-forward svc/argocd-server -n argocd 8080:443"

# Mostra senha inicial
Write-Host "`nUsuário: admin"
Write-Host "Senha inicial:"
kubectl -n argocd get secret argocd-initial-admin-secret `
  -o jsonpath="{.data.password}" | foreach { [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_)) }

Write-Host "`nAbra: https://localhost:8080 (ignore o aviso de certificado)" -ForegroundColor Cyan
