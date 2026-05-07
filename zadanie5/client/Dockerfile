FROM node:20-alpine
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
ENV REACT_APP_API_URL=http://localhost:4000
RUN npm run build
RUN npm install -g serve
COPY serve.json build/serve.json
EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000", "--no-clipboard"]
