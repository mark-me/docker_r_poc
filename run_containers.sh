docker run --name my_nginx -p 80:80 -d nginx
docker start my_nginx

docker run --rm -p 666:80 report_generator 
