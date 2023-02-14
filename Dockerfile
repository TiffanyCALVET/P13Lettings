FROM python:3-alpine

ENV PYTHONUNBUFFERED 1
EXPOSE 8080

RUN mkdir /code_P13_lettings

# work directory
WORKDIR /code_P13_lettings

COPY requirements.txt /code_P13_lettings/

# install psycopg2 dependencies
RUN apk update && \
    apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev && \
    pip install -r requirements.txt && \
    apk --purge del .build-deps


# install app
COPY . /code_P13_lettings/

# final configuration
CMD python manage.py runserver 0.0.0.0:8080