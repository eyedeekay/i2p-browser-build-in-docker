
build:
	docker build -t eyedeekay/i2p-browser-build .

br: configure build run

configure: update config

update:
	cd i2p-browser-build && git pull --force

config:
	cp i2p-browser-build/rbm.local.conf.i2p i2p-browser-build/rbm.local.conf

run: clean
	docker run -t -i \
		--name i2p-browser-build \
		--volume i2p-browser-build:/home/build/i2p-browser-build/ \
		eyedeekay/i2p-browser-build

clean:
	docker rm -f i2p-browser-build; true
