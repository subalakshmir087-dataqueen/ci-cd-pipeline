# Use Node.js LTS image
FROM node:20

# Create app directory
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY app/package*.json ./
RUN npm install

# Copy app source code
COPY app/ ./

# Expose port
EXPOSE 3000

# Start app
CMD ["npm", "start"]

