# syntax=docker/dockerfile:1
FROM python:3-alpine

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYCODE 1
EXPOSE 8080

RUN mkdir /code_P13_lettings

# work directory
WORKDIR /code_P13_lettings

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

# install app dependencies
RUN pip install --upgrade pip
COPY requirements.txt /code_P13_lettings/
RUN pip install -r requirements.txt

# install app
COPY . /code_P13_lettings/

# final configuration
CMD python manage.py runserver 0.0.0.0:8080