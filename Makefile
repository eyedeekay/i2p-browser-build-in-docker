
user=build

br: configure build run

pr: configure pull run

build: deps
	docker build -t eyedeekay/i2p-browser-build-in-docker .

configure: update config

pull:
	docker pull eyedeekay/i2p-browser-build-in-docker

update:
	cd i2p-browser-build || git clone https://github.com/eyedeekay/i2p-browser-build
	cd i2p-browser-build && git pull --force origin master

config:
	cp i2p-browser-build/rbm.local.conf.i2p i2p-browser-build/rbm.local.conf

run: clean
	docker run -t -i \
		--cap-add SYS_RESOURCE \
		--user "$(user)" \
		--name i2p-browser-build \
		--volume i2p-browser-build:/home/build/i2p-browser-build/ \
		eyedeekay/i2p-browser-build-in-docker

clean:
	docker rm -f i2p-browser-build; true

deps:
	docker build -f Dockerfile.tbb-build-deps -t eyedeekay/tbb-deb-deps .
	docker build -f Dockerfile.rbm-subs -t eyedeekay/tbb-build-deps .
	docker push eyedeekay/tbb-deb-deps; true
	docker push eyedeekay/tbb-build-deps; true
