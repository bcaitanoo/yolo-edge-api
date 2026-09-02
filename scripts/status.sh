#!/bin/bash

# Temperatura da CPU (risco: throttling acima de 80°C) 

watch -n 2 'cat /sys/class/thermal/thermal_zone0/temp | awk "{print \$1/1000 \" °C\"}"' 

 

# Uso de memória em tempo real 

watch -n 2 'free -h' 

 

# Stats do container (CPU, RAM, I/O de rede) 

docker stats yolo-api 

 

# Script consolidado de status do sistema 

echo '--- Status do Sistema ---' 

echo -n 'Temperatura: ' 

cat /sys/class/thermal/thermal_zone0/temp | awk '{print $1/1000 " °C"}' 

echo -n 'RAM livre: ' 

free -h | grep Mem | awk '{print $4}' 

echo -n 'API status: ' 

curl -sf http://localhost:8000/health | jq -r '.status' 

echo -n 'Requests totais: ' 

curl -sf http://localhost:8000/metrics | jq -r '.total_requests' 

echo -n 'Latência média: ' 

curl -sf http://localhost:8000/metrics | jq -r '.avg_inference_ms' 

echo ' ms' 
