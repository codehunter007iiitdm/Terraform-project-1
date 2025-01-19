#!/bin/bash

# Update the package list and install Python3
apt update
apt install -y python3

# Create a directory to host the website
mkdir -p /var/www/html

# Create the index.html file with "Hello World" content for the second instance
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>My EC2 Instance</title>
</head>
<body>
  <h1>Hello World from the second EC2 instance</h1>
</body>
</html>
EOF

# Change to the directory containing the website files
cd /var/www/html

# Start a Python3 HTTP server to serve the files on port 80
nohup python3 -m http.server 80 > /var/log/python-server.log 2>&1 &
