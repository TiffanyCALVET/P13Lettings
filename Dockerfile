# syntax=docker/dockerfile:1
FROM python:3-alpine

# work directory
WORKDIR /usr/src/app

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYCODE 1
EXPOSE 8080

COPY . .

# install app dependencies
RUN \
    apk add --no-cache postgresql-libs && \
    apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
    python3 -m pip install -r requirements.txt --no-cache-dir && \
    apk --purge del .build-deps && \
    python3 manage.py collectstatic --noinput --clear && \
    python3 manage.py dumpdata -o data.json


# final configuration
CMD python manage.py runserver 0.0.0.0:8080