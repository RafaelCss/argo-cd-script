# Instalação Local do Argo CD no Windows com Docker Desktop

Este repositório contém um script PowerShell para instalar o [Argo CD](https://argo-cd.readthedocs.io/) em um ambiente **Kubernetes local via Docker Desktop no Windows**.

## 📋 Requisitos

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) com Kubernetes ativado
- PowerShell
- `kubectl` (já vem com o Docker Desktop)

## 🚀 Passo a Passo

### 1. Habilitar o Kubernetes no Docker Desktop

- Abra o Docker Desktop
- Vá em: **Settings → Kubernetes → Enable Kubernetes**
- Clique em **Apply & Restart**

### 2. Clonar este repositório
[https://github.com/RafaelCss/argo-cd-script](https://github.com/RafaelCss/argo-cd-script/)


### 3. Executar o script de instalação

Abra o PowerShell como **administrador** e execute:

```powershell
.\instalar-argocd.ps1
```

### 4. Acesso à interface do Argo CD

- Interface: [https://localhost:8080](https://localhost:8080)
- Usuário: `admin`
- Senha: gerada automaticamente e exibida ao final do script

Ignore o aviso de certificado autoassinado no navegador.

## 📁 Arquivos

- `instalar-argocd.ps1` — script principal de instalação e inicialização do Argo CD

## 🧩 Tecnologias utilizadas

- PowerShell
- Kubernetes via Docker Desktop
- Argo CD

## 📄 Licença

Este projeto está licenciado sob a licença MIT.
