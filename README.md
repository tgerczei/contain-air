# contain-air
## What?
Exports Prometheus metrics from Philips smart air purifiers ("i" series).
## How?
Using the GitHub project [urbas/py-air-control-exporter](https://github.com/urbas/py-air-control-exporter).

### Usage example
docker run -d --log-driver none -P --name air-purifier-monitoring --memory=50m --restart on-failure tgerczei/py-air-control-exporter --host ip.address.of.purifier --protocol coap
