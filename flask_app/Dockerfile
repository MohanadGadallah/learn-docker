FROM python:3.9-rc-buster


WORKDIR /code

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_ENV=development
###



COPY requirements.txt requirements.txt


RUN pip3 install -r requirements.txt


COPY . .


CMD ["flask", "run"]

#docker build -t flask_app:1.0 .
#docker run -port 4000:5000 flask_app:1.0 