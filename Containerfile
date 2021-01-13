FROM python:3.7-alpine AS builder
RUN	apk --update --no-cache add build-base && \
	python -m pip install --cache-dir=/tmp/ \
		click==7.1.2 \
		CoAPthon3==1.0.1 \
		Flask==1.1.2 \
		itsdangerous==1.1.0 \
		Jinja2==2.11.2 \
		MarkupSafe==1.1.1 \
		prometheus-client==0.9.0 \
		py-air-control==2.2.0 \
		py-air-control-exporter==0.3.0 \
		pycryptodomex==3.9.9 \
		Werkzeug==1.0.1 && \
	mkdir /wheels/ && \
        find /tmp/wheels -type f -name '*.whl' | xargs -I{} cp -v {} /wheels/

FROM python:3.7-alpine
COPY --from=builder /wheels /packages

RUN	python -m pip install --no-cache-dir --no-index --find-links=packages/ \
		CoAPthon3==1.0.1 \
		MarkupSafe==1.1.1 \
		pycryptodomex==3.9.9 && \
	python -m pip install --no-cache-dir \
                click==7.1.2 \
		Werkzeug==1.0.1 \
		Jinja2==2.11.2 \
                Flask==1.1.2 \
                itsdangerous==1.1.0 \
                py-air-control==2.2.0 \
		py-air-control-exporter==0.3.0 && \
        rm -rf /packages && \
	adduser -s /bin/false -S -D python

EXPOSE 9896
USER python
WORKDIR /home/python
ENTRYPOINT ["py-air-control-exporter"]
CMD ["--host", "0.0.0.0"]

