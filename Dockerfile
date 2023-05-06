FROM node:16

# Set working directory
WORKDIR /app

# Copy package.json and yarn.lock
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy app files
COPY . .

# Start the app
CMD ["yarn", "start"]
