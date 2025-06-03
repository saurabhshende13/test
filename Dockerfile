# Use compatible Node version
FROM node:20-alpine

WORKDIR /app

COPY package.json package-lock.json ./

# Clean install
RUN npm install

COPY . .

RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]

