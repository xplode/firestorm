# firestorm
### Firefox load gen on demand

Uses xvfb, selenium, firefox and a go webserver 

## Setup
Setting up firestorm is easy, simply deploy a debian based linux server (make sure port 80 is open to you), login to the server and then:
```bash
git clone https://github.com/xplode/firestorm.git
cd firestorm
./headless-setup.sh
./app-setup.sh
sudo go run server.go
```

## Generating load
You can command firestorm to generate load via the firestorm http api.

Required query parameters are:
* test-url=Url to request.
* iterations=Number of times to load page from a browser.
* concurrency=Number of browsers to concurrently run.
```bash
curl '<firestorm server ip>?test-url=<url to request>&iterations=<number of times to load page froma browser>&concurrency=<number of browsers>'
```

So if your firestorm server is 1.2.3.4 and you want to load test http://example.com from two browsers concurrently sending a total of 200 requests you would do:
```bash
curl 'http://1.2.3.4?test-url=http://example.com&iterations=100&concurrency=1'
```
### Firestorm is still under development and very much in beta, so there's not a lot of error recovery or robustness at this point.
