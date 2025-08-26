# Kubernetes Autoscaling com K3d, NGINX e HPA

Este projeto demonstra como criar um cluster Kubernetes local com K3d e aplicar escalabilidade horizontal automática utilizando o Horizontal Pod Autoscaler (HPA) sobre uma aplicação NGINX.


## Pré-requisitos
	•	Docker instalado

	•	kubectl configurado
	
    •	k3d instalado (k3d.io)
	
    •	(Linux/macOS) acesso a terminal bash/zsh


## Estrutura do Projeto
```
atividade_ponderada_1/
├── k8s/
│   ├── namespace.yaml
│   ├── deployment.yaml
│   ├── service.yaml
│   ├── hpa.yaml
│   └── kustomization.yaml
├── scripts/
│   ├── create-cluster.sh
│   ├── install-metrics-server.sh
│   ├── port-forward.sh
│   └── load-test.sh
└── README.md
```

## Passo a Passo

1. Criar o cluster K3d

`./scripts/create-cluster.sh`

Isso cria o cluster k3d-nginx-hpa com 1 server e 2 agents, além de mapear a porta 8080.


2. Instalar o metrics-server

`./scripts/install-metrics-server.sh`

Esse componente coleta métricas de CPU/Memória dos pods e nodes.
Confirme com:

```
kubectl top nodes
kubectl top pods -A
```


3. Aplicar a aplicação e o HPA

`kubectl apply -k k8s/`

Isso cria:
	•	Namespace autoscale-demo
	•	Deployment nginx (2 réplicas)
	•	Service nginx (ClusterIP)
	•	HPA nginx-hpa (meta: 50% CPU, 2–10 réplicas)

Verifique:
```
kubectl -n autoscale-demo get all
kubectl -n autoscale-demo get hpa
```


4. Acessar a aplicação

Opção A — Port-forward:

`kubectl -n autoscale-demo port-forward svc/nginx 8080:80`

Abra: http://localhost:8080

Opção B — Se preferir expor como LoadBalancer:

`kubectl -n autoscale-demo patch svc/nginx -p '{"spec":{"type":"LoadBalancer"}}'`

E acesse http://localhost:8080


5. Gerar carga de teste

`./scripts/load-test.sh`

Por padrão, roda com:
	•	2 minutos de duração
	•	100 conexões simultâneas

Saída esperada: estatísticas de requisições/segundos, latência média etc.



6. Observar métricas e autoscaling

Em paralelo ao teste de carga:
```
kubectl -n autoscale-demo get hpa
kubectl -n autoscale-demo top pods
kubectl top nodes
kubectl -n autoscale-demo describe hpa nginx-hpa
```


## Discussão das Métricas (Resultados Obtidos)

Durante a execução, observamos:
	•	Pods NGINX
```
kubectl -n autoscale-demo get pods
NAME                     READY   STATUS    RESTARTS   AGE
nginx-85d68874b7-bxztd   1/1     Running   0          13m
nginx-85d68874b7-jsfkz   1/1     Running   0          13m
```

	•	HPA monitorando CPU

```
kubectl -n autoscale-demo get hpa
NAME        REFERENCE          TARGETS       MINPODS   MAXPODS   REPLICAS   AGE
nginx-hpa   Deployment/nginx   cpu: 2%/50%   2         10        2          13m
```
O consumo médio foi apenas 2% da meta de 50%, portanto o HPA não precisou escalar além das 2 réplicas mínimas.

	•	Uso de recursos

```
kubectl -n autoscale-demo top pods
NAME                     CPU(cores)   MEMORY(bytes)
nginx-85d68874b7-bxztd   1m           8Mi
nginx-85d68874b7-jsfkz   1m           8Mi

kubectl top nodes
NAME                         CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
k3d-k3d-nginx-hpa-agent-0    50m          0%     192Mi           2%
k3d-k3d-nginx-hpa-agent-1    58m          0%     242Mi           3%
k3d-k3d-nginx-hpa-server-0   43m          0%     428Mi           5%

O NGINX servindo página estática consumiu muito pouco CPU/memória, então o cluster ficou estável.
```

📝 Conclusão
	•	O HPA foi configurado corretamente e monitorou a aplicação.
    
	•	Como a carga gerada não saturou os requests de CPU (50m), não houve necessidade de escalar.
	
    •	Isso mostra que o autoscaler só age quando a utilização excede a meta.

