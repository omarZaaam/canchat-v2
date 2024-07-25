# Removes any existing Open WebUI and Pipelines containers/ volumes - uncomment if you need a fresh start
# docker rm --force pipelines
# docker rm --force open-webui 
# docker volume rm pipelines
# docker volume rm open-webui 

# Runs the containers with Ollama image for Open WebUI and the Pipelines endpoint in place
docker run -d -p 9099:9099 --add-host=host.docker.internal:host-gateway -v pipelines:/app/pipelines --name pipelines --restart always --env-file .env ghcr.io/open-webui/pipelines:latest
docker run -d -p 3000:8080 -v ~/.ollama:/root/.ollama -v open-webui:/app/backend/data --name open-webui --restart always -e OPENAI_API_BASE_URL=http://host.docker.internal:9099 -e OPENAI_API_KEY=0p3n-w3bu! ghcr.io/open-webui/open-webui:ollama

docker run -d -p 4002:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui-sql --restart always -e OPENAI_API_BASE_URL=http://host.docker.internal:9099 -e OPENAI_API_KEY=0p3n-w3bu! ghcr.io/open-webui/open-webui:main
