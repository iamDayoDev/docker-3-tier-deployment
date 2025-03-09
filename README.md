<<<<<<< HEAD
# docker-3-tier-deployment
This is the final README content I want to keep.

=======

# **Deploy a This Application on Ubuntu VM with Nginx**

This guide provides step-by-step instructions to deploy and run a **This React application** on an **Ubuntu VM** using **Nginx**, making it accessible from a **public IP**.

---


## **1. Install Node.js and npm**  
Since React requires **Node.js** and **npm**, install them first:  

```sh
sudo apt update
sudo apt install -y nodejs npm
```

Verify the installation:  

```sh
node -v
npm -v
```

---

## **2. Install Nginx**  
Update package lists and install **Nginx**:  

```sh
sudo apt install -y nginx
```

Start and enable Nginx:  

```sh
sudo systemctl start nginx
sudo systemctl enable nginx
```

Check Nginx status:  

```sh
systemctl status nginx
```

---

## **3. Clone the React Application from GitHub**  
Navigate to a temporary directory and **clone the repository**:  

```sh
cd /tmp
git clone https://github.com/pravinmishraaws/my-react-app.git
cd my-react-app
```

---

## **4. Install Dependencies and Build the React App**  
Install required dependencies:  

```sh
npm install
```

Build the React application:  

```sh
npm run build
```

This will generate a **`build/`** folder with production-ready static files.

---

## **5. Deploy Build Files to Nginx Web Directory**  
Remove any existing files in the Nginx web directory:  

```sh
sudo rm -rf /var/www/html/*
```

Copy the React **build files** to `/var/www/html/`:  

```sh
sudo cp -r build/* /var/www/html/
```

Set proper permissions:  

```sh
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
```

---

## **6. Configure Nginx for React**  
Nginx configuration file:   

```
echo 'server {
    listen 80;
    server_name _;
    root /var/www/html;
    index index.html;
    
    location / {
        try_files $uri /index.html;
    }

    error_page 404 /index.html;
}' | sudo tee /etc/nginx/sites-available/default > /dev/null

```

Restart Nginx to apply the changes:  

```sh
sudo systemctl restart nginx
```

---

## **7. Allow Public Access (Firewall Setup)**  
Allow HTTP traffic through the firewall:  

```sh
sudo ufw allow 'Nginx Full'
```

Check firewall status:  

```sh
sudo ufw status
```

---

## **8. Find Your Public IP and Access the Application**  
Retrieve the **public IP** of your Ubuntu VM:  

```sh
curl ifconfig.me
```

Now, students can **access the React application** in a browser using:  

```
http://<your-public-ip>
```

For example, if the public IP is **203.0.113.25**, visit:  

```
http://203.0.113.25
```

---

## **9. Verify the Deployment**  
Ensure Nginx is correctly serving the React app:  

```sh
curl <your-public-ip>
```

If successful, your **React app is live!**  

---

<<<<<<< HEAD
## **Conclusion**
**Your React app is now deployed on an Ubuntu VM using Nginx and accessible from the public IP!**   
>>>>>>> 1bbff15 (Update README.md)
=======
## **Your React App is Now Live on Ubuntu with Nginx!**  
Now your **React application** is deployed on an **Ubuntu VM with Nginx**, accessible from a **public IP**. 
>>>>>>> 3cbbd21 (Update README.md)
