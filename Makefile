GOOS   ?= linux
GOARCH ?= arm
GOARM  ?= 7

all:
	GOOS=$(GOOS) GOARCH=$(GOARCH) GOARM=$(GOARM) go get -t -d -v ./...
	GOOS=$(GOOS) GOARCH=$(GOARCH) GOARM=$(GOARM) go build -ldflags " -X main.stratuxVersion=`git describe --abbrev=0 --tags` -X main.stratuxBuild=`git log -n 1 --pretty=%H`" main/gen_gdl90.go main/traffic.go main/ry835ai.go main/network.go main/managementinterface.go main/sdr.go main/uibroadcast.go
	cd dump978 && make lib

test:
	sh -c true

www:
	mkdir -p /var/www
	mkdir -p /var/www/css
	cp web/css/*.css /var/www/css
	mkdir -p /var/www/js
	cp web/js/*.js /var/www/js
	mkdir -p /var/www/img
	cp web/img/logo*.png /var/www/img
	cp web/img/screen*.png /var/www/img
	mkdir -p /var/www/maui
	mkdir -p /var/www/maui/js
	cp web/maui/js/angular-ui-router.min.js /var/www/maui/js
	cp web/maui/js/mobile-angular-ui.min.js /var/www/maui/js
	cp web/maui/js/angular.min.js /var/www/maui/js
	cp web/maui/js/mobile-angular-ui.gestures.min.js /var/www/maui/js
	cp web/maui/js/mobile-angular-ui.core.min.js /var/www/maui/js
	mkdir -p /var/www/maui/css
	cp web/maui/css/mobile-angular-ui-hover.min.css /var/www/maui/css
	cp web/maui/css/mobile-angular-ui-desktop.min.css /var/www/maui/css
	cp web/maui/css/mobile-angular-ui-base.min.css /var/www/maui/css
	mkdir -p /var/www/maui/fonts
	cp web/maui/fonts/fontawesome-webfont.woff /var/www/maui/fonts
	mkdir -p /var/www/plates
	cp web/plates/*.html /var/www/plates
	mkdir -p /var/www/plates/js
	cp web/plates/js/*.js /var/www/plates/js
	cp web/index.html /var/www

install:
	cp -f gen_gdl90 /usr/bin/gen_gdl90
	chmod 755 /usr/bin/gen_gdl90
	cp -f libdump978.so /usr/lib/
	
clean:
	rm -f gen_gdl90
