
COMPOSE = docker-compose -f docker-compose.yml
env:
	@echo "Setting up UID and GID for $(ENV) ..."
#	ifdef $(foo)
#    frobozz = yes
#	endif
all:

build:
	if [ !$(v) ]; then
	    exit 1
	fi
	docker-compose -f docker-compose.yml up -d
	docker-compose -f docker-compose-for-build.yml up -d
	yarn build
	docker cp ./public umami_umami_1:/app/public
	docker cp ./.next umami_umami_1:/app/.next

	docker commit appdemo umami_updated:{$}
	docker save myimage:latest | gzip > myimage_latest.tar.gz