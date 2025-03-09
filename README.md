<<<<<<< HEAD
# docker-3-tier-deployment
This is the final README content I want to keep.

=======

# **Deploy a This Application on Ubuntu VM with Nginx**

This guide provides step-by-step instructions to deploy and run a **This React application** on an **Ubuntu VM** using **Nginx**, making it accessible from a **public IP**.

---

## **1. Install Nginx**
First, update package lists and install Nginx:

```sh
sudo apt update
sudo apt install -y nginx
```

Start and enable Nginx:

```sh
sudo systemctl start nginx
sudo systemctl enable nginx
```

Verify that Nginx is running:

```sh
systemctl status nginx
```

You should see that Nginx is **active and running**.

---

## **2. Clone the React App and Build It**
Navigate to a temporary directory and **clone the repository**:

```sh
cd /tmp
git clone https://github.com/pravinmishraaws/my-react-app.git
```

Move into the project directory:

```sh
cd my-react-app
```

Install dependencies:

```sh
npm install
```

Build the React app for production:

```sh
npm run build
```

This will create a `build/` folder with the **static files** for deployment.

---

## **3. Deploy the Build Files to the Web Directory**
First, **remove any existing files** in the Nginx web directory:

```sh
sudo rm -rf /var/www/html/*
```

Now, **copy the newly built React files** to `/var/www/html/`:

```sh
sudo cp -r build/* /var/www/html/
```

Ensure the files have the correct ownership and permissions:

```sh
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html
```

---

## **4. Configure Nginx to Serve the React App**
Edit the Nginx configuration:

```sh
sudo nano /etc/nginx/sites-available/default
```

Replace the content with:

```nginx
server {
    listen 80;
    server_name _;

    root /var/www/html;
    index index.html;

    location / {
        try_files $uri /index.html;
    }

    error_page 404 /index.html;
}
```

Save the file (`CTRL + X`, then `Y`, then `ENTER`).

Restart Nginx to apply the changes:

```sh
sudo systemctl restart nginx
```

---

## **5. Open Firewall for Public Access**
If **UFW (Uncomplicated Firewall)** is enabled, allow HTTP traffic:

```sh
sudo ufw allow 'Nginx Full'
```

To check if the firewall is active:

```sh
sudo ufw status
```

---

## **6. Find Your Public IP and Share It with Students**
To find the **public IP** of your Ubuntu VM, run:

```sh
curl ifconfig.me
```

Now, students can **access the application** in their browser using:

```
http://<public-ip>
```

For example, if the public IP is `203.0.113.25`, students should visit:

```
http://203.0.113.25
```

---

## **7. Verify the Deployment**
To ensure the application is running correctly, run:

```sh
curl <public-ip>
```

If everything is set up properly, you should see the HTML content of the React app.

---

## **Conclusion**
**Your React app is now deployed on an Ubuntu VM using Nginx and accessible from the public IP!**   
>>>>>>> 1bbff15 (Update README.md)
