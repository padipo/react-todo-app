FROM node:lts-slim as build
WORKDIR /usr/src/app
ENV CI=true
COPY package.json yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build

#production with Nginx
FROM nginx:1.15
COPY --from=build /usr/src/app/build /usr/share/nginx/html
COPY --from=build /usr/src/app/nginx.conf /etc/nginx/conf.d/default.conf