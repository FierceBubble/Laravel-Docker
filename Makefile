build:
	docker build . -t laravel-docker:latest
stop:
	docker-compose stop
up:
	docker-compose up -d
down:
	docker-compose down
restart:
	docker-compose down && docker-compose up -d
ub:
	docker-compose up -d --build
it:
	docker-compose exec php bash
