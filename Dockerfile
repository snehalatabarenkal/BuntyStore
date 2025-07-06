# Use official Nginx image
FROM nginx:alpine

# Copy your HTML files into the Nginx web root
COPY index.html /usr/share/nginx/html/

# (Optional) Copy other static assets like CSS, JS
# COPY assets/ /usr/share/nginx/html/assets/

EXPOSE 80
