FROM python:3.6.1

# Create the group and user to be used in this container
RUN groupadd flaskgroup && useradd -m -g flaskgroup -s /bin/bash flask
 
RUN apt-get update 

RUN mkdir /app

WORKDIR /app


# Install the package dependencies (this step is separated
# from copying all the source code to avoid having to
# re-install all python packages defined in requirements.txt
# whenever any source code change is made)
COPY requirements.txt /app

RUN pip install --no-cache-dir -r requirements.txt

# Copy source code into container (or image?)
COPY . /app

RUN chown -R flask:flaskgroup /app
 
USER flask

ENV FLASK_ENV="docker"

EXPOSE 5000
