ENV?=local
APP_DIR=/var/local/apps/

ifeq ($(ENV),prod)
	VERSION:=$(shell git describe --exact-match --tags HEAD)
else ifeq ($(ENV),local)
	VERSION:=local
else
	VERSION:=$(shell git rev-parse --short HEAD)
endif

ecr_repo:=flash-sale
image_name:=$(ecr_repo):$(ENV)-$(VERSION)

compile:
	rm -rf ./build
	./node_modules/.bin/tsc
	cp package.json pm2.json README.md ./build/
	cp ./profiles/$(ENV).env ./build/.env
	mkdir ./build/scripts/ && cp ./scripts/start.sh ./build/scripts/ && chmod +x ./build/scripts/*

npm_install:
	cd ./build && npm install --production

build: compile npm_install
	@docker build \
		-t $(image_name) \
		-f docker/dockerfile .

run_local:
	docker run \
		-p 80:3000 \
		-p 5858:5859 \
		-v $(shell pwd)/:$(APP_DIR) \
		-it $(image_name)

run_mongo:
	docker start flash-mongo \
	|| docker run --name flash-mongo \
		-v $(pwd)/data/db:/data/db \
		-e 'MONGO_INITDB_ROOT_USERNAME=admin' -e 'MONGO_INITDB_ROOT_PASSWORD=Reg@)!&!!!!' \
		-d mongo:3.6-jessie \
		--auth
