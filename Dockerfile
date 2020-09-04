FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80  
#This expose only works for port exposure on AWS beanstalk
COPY --from=builder /app/build /usr/share/nginx/html
# NGINX starts up automatically so don't need a run command