
br: configure build run

pr: configure pull run

build: deps
	docker build -t eyedeekay/i2p-browser-build .

configure: update config

pull:
	docker pull eyedeekay/i2p-browser-build

update:
	cd i2p-browser-build || git clone https://github.com/eyedeekay/i2p-browser-build
	cd i2p-browser-build && git pull --force origin master

config:
	cp i2p-browser-build/rbm.local.conf.i2p i2p-browser-build/rbm.local.conf

run: clean
	docker run -t -i \
		--name i2p-browser-build \
		--volume i2p-browser-build:/home/build/i2p-browser-build/ \
		eyedeekay/i2p-browser-build

clean:
	docker rm -f i2p-browser-build; true

deps:
	docker build -f Dockerfile.tbb-build-deps -t eyedeekay/tbb-deb-deps .
	docker build -f Dockerfile.rbm-subs -t eyedeekay/tbb-build-deps .
	docker push eyedeekay/tbb-deb-deps eyedeekay/tbb-build-deps
