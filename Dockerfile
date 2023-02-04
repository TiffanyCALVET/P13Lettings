# syntax=docker/dockerfile:1
FROM python:3.9-alpine

ENV PYTHONUNBUFFERED 1
EXPOSE 8000

RUN mkdir /code_P13_lettings

# work directory
WORKDIR /code_P13_lettings

COPY requirements.txt /code_P13_lettings/

# install app dependencies
RUN pip install -r requirements.txt

# install app
COPY . /code_P13_lettings/

# final configuration
CMD python manage.py runserver 0.0.0.0 --port 8000