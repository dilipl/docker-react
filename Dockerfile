# This is a named phase. There are 2 stages, one to build and one to run code on nginx
FROM node:alpine as builder 
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Each From terminates the previous block
FROM nginx
# copy /app/build contents that was built in previous stage to nginx's html folder
COPY --from=builder /app/build /usr/share/nginx/html
#No need to start nginx as that happens automatically
