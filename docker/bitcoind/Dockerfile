# Use an official Python runtime as a parent image
FROM ubuntu

# Set the working directory to X
WORKDIR ~/.bitcoin

# Install app
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update
RUN apt-get install bitcoind -y

RUN mkdir -p ~/.bitcoin

ADD bitcoin.conf "~/.bitcoin"

# Make port X available to the world outside this container
EXPOSE 18332

# Run app.py when the container launches
CMD ["bitcoind"]
