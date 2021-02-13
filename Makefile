HUGO := hugo

.PHONY: dep build build-production build-prod prod serve

build-prod: build-production

prod: build-production

dep:
	git submodule update --init --recursive

update-dep:
	git submodule update --init --recursive --remote

build: content layouts static data assets config.toml
	$(HUGO) ${extra_args}

build-production: content layouts static data assets config.toml
	HUGO_ENV=production $(HUGO) --minify --cleanDestinationDir ${extra_args}

serve:
	$(HUGO) serve ${extra_args}

deploy: build-production
	rclone sync ./public MICRO:"public_html/autonomylab"
