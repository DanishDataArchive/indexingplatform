Installation notes:

1. Clone this repository
2. Install [eXist-db-2.2](http://sourceforge.net/projects/exist/files/Stable/2.2/) (Leave the admin password blank for the ease of testing this product)
3. Install haproxy (sudo apt-get install haprox)
4. Now go to the eXist-db installation in your browser [http://localhost:8080/exist](http://localhost:8080/exist)
  1. Install xfunc from clone_dir/external_lib/
5. Edit clone_dir/scripts/config.xml according to your details
6. ant apply-config -> you can now start your haproxy instance using the generated config in clone_dir/scripts/bin/haproxy (sudo haproxy -d -f haproxy.cfg)
7. Now that you have changed the config.xml to point at your ddi-l files run
  1. ant deploy
  2. ant store
8. Go to [http://localhost:8080/exist](http://localhost:8080/exist) open eXide and run /db/apps/dda-denormalization/denormalize.xquery
9. Now point your browser at [http://localhost/catalogue](http://localhost/catalogue)
10. Have fun
