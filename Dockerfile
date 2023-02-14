# syntax=docker/dockerfile:1
FROM python:3-alpine

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYCODE 1
EXPOSE 8080

RUN mkdir /code_P13_lettings

# work directory
WORKDIR /code_P13_lettings

COPY requirements.txt /code_P13_lettings/

# install app dependencies
RUN \
    apk add --no-cache postgresql-libs && \
    apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
    pip install -r requirements.txt --no-cache-dir && \
    apk --purge del .build-deps && \
    python manage.py collectstatic --noinput --clear && \
    python manage.py dumpdata -o data.json


# install app
COPY . /code_P13_lettings/

# final configuration
CMD python manage.py runserver 0.0.0.0:8080