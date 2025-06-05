# Docker Compose for Multi-Tier Project

## **Step 1: Define the Project Structure**
Create the following folder structure:

```sh
mkdir -p multi-tier-app/{frontend,backend,database}
cd multi-tier-app
touch docker-compose.yml
```

Final structure:
```
multi-tier-app/
│-- frontend/
│   └── Dockerfile
│-- backend/
│   └── Dockerfile
│-- database/
│   └── Dockerfile
│-- docker-compose.yml
```

---

## **Step 2: Write the `docker-compose.yml` File**
Inside `multi-tier-app/docker-compose.yml`, add the following configuration:

```yaml
version: "3.3"

services:
  database:
    build: ./database
    container_name: db
    restart: always
    networks:
      - backend-network
    volumes:
      - mongo-data:/data/db
    ports:
      - "27017:27017"

  backend:
    build: ./backend
    container_name: api
    restart: always
    depends_on:
      - database
    networks:
      - backend-network
      - frontend-network

  frontend:
    build: ./frontend
    container_name: ui
    restart: always
    depends_on:
      - backend
    networks:
      - frontend-network
    ports:
      - "80:80"

networks:
  backend-network:
  frontend-network:

volumes:
  mongo-data:
```

---

## **Step 3: Create the Dockerfiles**
### **Database (MongoDB)**
Inside `multi-tier-app/database/Dockerfile`:
```dockerfile
# Use the official MongoDB image
FROM mongo:latest

# Expose MongoDB's default port
EXPOSE 27017
```

---

### **Backend (Node.js with Express)**
Inside `multi-tier-app/backend/Dockerfile`:
```dockerfile
# Use the official Node.js image
FROM node:18

# Set working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm init -y && npm install express mongoose cors body-parser

# Copy application code
COPY . .

# Create index.js with Express API and MongoDB connection
RUN echo "const express = require('express'); \
const mongoose = require('mongoose'); \
const app = express(); \
const PORT = 80; \
mongoose.connect('mongodb://db:27017/mydb', { useNewUrlParser: true, useUnifiedTopology: true }) \
.then(() => console.log('Connected to MongoDB')) \
.catch(err => console.log('MongoDB connection error:', err)); \
app.get('/', (req, res) => res.send('Hello from Backend')); \
app.listen(PORT, () => console.log('Backend running on port ' + PORT));" > index.js

# Expose port 80
EXPOSE 80

# Run the application
CMD ["node", "index.js"]
```

---

### **Frontend (React with Nginx)**
Inside `multi-tier-app/frontend/Dockerfile`:
```dockerfile
# Use the official lightweight Nginx image
FROM nginx:alpine

# Expose port 80 for incoming traffic
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
```

---

## **Step 4: Build and Start the Application**

**Install docker-compose**

```sh
sudo apt  install docker-compose
```


Navigate to `multi-tier-app/` and run:
```sh
docker-compose up --build -d
```
- `--build` forces a rebuild of images.
- `-d` runs services in the background.

---

## **Step 5: Verify Everything is Running**
### **Check Running Containers**
```sh
docker ps
```
Expected output:
```
CONTAINER ID   IMAGE           STATUS         NAMES
a1b2c3d4e5f6   frontend-app    Up 10 min     ui
b2c3d4e5f6a1   backend-app     Up 10 min     api
c3d4e5f6a1b2   mongo           Up 10 min     db
```

---

## **Step 6: Test the Application**
### **Check Frontend (React)**
Since the frontend is exposed on **port 80**, test it:
```sh
curl http://localhost
```
Expected output:
```
Welcome to nginx!
```

### **Check Backend API**
Since the backend is also exposed on **port 80**, test it:
```sh
curl http://localhost
```
Expected output:
```
Hello from Backend
```

---

## **Step 7: Manage Services**
### **Restart the Backend**
```sh
docker-compose restart backend
```

### **Stop the Entire Application**
```sh
docker-compose down
```

---

## **Key Benefits of Using Docker Compose**

 **Setup Complexity** 
 - Without Dokcer Compose
 
 Manual container creation & linking 

 - With Compose

 Defined in a single `docker-compose.yml` file 

 **Dependency Handling**
 -Without Docker Compose

 Must manually start services in order

 - With Compose

 `depends_on` ensures proper startup

 **Networking**
 - Without DOcker Compose

 Manually create networks 

 - With Compose

 Networks are defined in Compose 

 **Storage**
 -Without Docker Compose

 Manually attach volumes
 - With Compose

 Managed by Compose 

 **Scalability**
 - WIthout Docker compose

 Difficult to scale
 - With Compose

 Easily scale services with `docker-compose up --scale backend=3` |