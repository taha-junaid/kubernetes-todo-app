FROM python:3.8-alpine

WORKDIR /app

# Copy the requirements.txt file into the container
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip3 install -r requirements.txt
# Copy the current directory contents into the container at /app
COPY . .

# Set environment variables
ENV FLASK_APP=app.py
ENV FLASK_ENV=production

# Expose the port that Flask is running on
EXPOSE 5000

# Run the command to start Flask
CMD flask run -h 0.0.0.0 -p 5000


