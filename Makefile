# VARS
LOGIN = nait-bou 
DATA_PATH = /home/$(LOGIN)/data

# COMPOSE
COMPOSE_FILE = ./srcs/docker-compose.yml
DOCKER_COMPOSE = docker compose -f $(COMPOSE_FILE)

# COLORS
GREEN = \033[0;32m
RED = \033[0;31m
RESET = \033[0m

all: up

# 1. Create the data directories required by the subject 
# 2. Build and start the containers in detached mode
up:
	@echo "$(GREEN)Creating data directories at $(DATA_PATH)...$(RESET)"
	@sudo mkdir -p $(DATA_PATH)/wordpress
	@sudo mkdir -p $(DATA_PATH)/mariadb
	@echo "$(GREEN)Building and starting Inception...$(RESET)"
	@sudo $(DOCKER_COMPOSE) up  --build

# Stop the containers
down:
	@echo "$(RED)Stopping containers...$(RESET)"
	@sudo $(DOCKER_COMPOSE) down

# Stop containers and remove images/volumes/networks
clean: down
	@echo "$(RED)Cleaning Docker system...$(RESET)"
	@sudo docker system prune -af

# Deep clean: Remove everything including the persistent data on your hard drive
fclean: clean
	@echo "$(RED)Removing data directories (sudo required)...$(RESET)"
	@sudo rm -rf $(DATA_PATH)

# Rebuild everything from scratch
re: fclean all

# Handy rule to see logs
logs:
	@sudo $(DOCKER_COMPOSE) logs -f

.PHONY: all up down clean fclean re logs