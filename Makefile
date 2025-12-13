
LOGIN = nait-bou 
DATA_PATH = /home/$(LOGIN)/data


COMPOSE_FILE = ./srcs/docker-compose.yml
DOCKER_COMPOSE = docker compose -f $(COMPOSE_FILE)


GREEN = \033[0;32m
RED = \033[0;31m
RESET = \033[0m

all: up


up:
	@echo "$(GREEN)Creating data directories at $(DATA_PATH)...$(RESET)"
	@sudo mkdir -p $(DATA_PATH)/wordpress
	@sudo mkdir -p $(DATA_PATH)/mariadb
	@echo "$(GREEN)Building and starting Inception...$(RESET)"
	@sudo $(DOCKER_COMPOSE) up  --build


down:
	@echo "$(RED)Stopping containers...$(RESET)"
	@sudo $(DOCKER_COMPOSE) down


clean: down
	@echo "$(RED)Cleaning Docker system...$(RESET)"
	@sudo docker system prune -af


fclean: clean
	@echo "$(RED)Removing data directories (sudo required)...$(RESET)"
	@sudo rm -rf $(DATA_PATH)


re: fclean all


logs:
	@sudo $(DOCKER_COMPOSE) logs -f

.PHONY: all up down clean fclean re logs