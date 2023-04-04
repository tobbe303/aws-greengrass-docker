RELEASE ?= 2.9.5

.PHONY: clean image

all: image

clean:
	$(RM) greengrass-$(RELEASE).zip

greengrass-%.zip:
	wget https://d2s8p88vqu9w66.cloudfront.net/releases/greengrass-$(RELEASE).zip

greengrass.zip.sha256: greengrass-$(RELEASE).zip
	sha256sum $@ > $<

image: greengrass-$(RELEASE).zip greengrass.zip.sha256
	docker build \
		--build-arg GREENGRASS_RELEASE_VERSION=$(RELEASE) \
		-t aws-iot-greengrass:$(RELEASE) .
