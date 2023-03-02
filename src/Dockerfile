FROM alpine:3.17.2

WORKDIR /app

RUN apk add --no-cache gcc

COPY . .

RUN chmod +x /app/rewrk
# example ./rewrk -d 3s -h http://192.168.224.1:5000/api/users
