Installation notes:

1. Clone this repository
2. Install [eXist-db-3.6](https://bintray.com/existdb/releases/exist/3.6.0/view) (Leave the admin password blank for the ease of testing this product)
3. Install haproxy (sudo apt-get install haprox)
4. Or install Nginx (sudo apt-get install nginx)
5. Now go to the eXist-db installation in your browser [http://localhost:8080/exist](http://localhost:8080/exist)
  1. Install xfunc from clone_dir/external_lib/
6. Edit clone_dir/scripts/config.xml according to your details
7. ant apply-config -> you can now start your haproxy instance using the generated config in clone_dir/scripts/bin/haproxy (sudo haproxy -d -f haproxy.cfg)
8. Or use Nginx with conf file located at clone_dir/scripts/bin/nginx
9. Now that you have changed the config.xml to point at your ddi-l files run
  1. ant deploy
  2. ant store
10. Go to [http://localhost:8080/exist](http://localhost:8080/exist) open eXide and run /db/apps/dda-denormalization/denormalize.xquery
11. Now point your browser at [http://localhost/catalogue](http://localhost/catalogue)
12. Have fun
