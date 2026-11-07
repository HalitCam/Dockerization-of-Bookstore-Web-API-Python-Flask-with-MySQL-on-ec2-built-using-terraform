FROM python:3.13.18-alpine3.23
WORKDIR /home/bookstore-app
COPY . .
RUN pip install -r requirements.txt
CMD ["python", "bookstore-api.py"]

