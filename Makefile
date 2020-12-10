hydra-up:
	docker-compose -f quickstart.yml up --build

clean-up:
	docker rm hydra-auth-practice-kit_hydra_1 hydra-auth-practice-kit_hydra-migrate_1 && \
		docker volume rm hydra-auth-practice-kit_hydra-sqlite
