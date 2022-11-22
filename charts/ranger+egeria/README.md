**Simple chart for ranger & mariaDB**

^^ Egeria added -- tbd


How to install ranger using this chart

* Install Kubernetes/start
* 'helm install ranger'
* Wait for ranger to start (bootstrap takes up to a minute)
* Go to http://localhost:6080

**todos**
 - could make this chart depend on a mariadb chart rather than include it
 - need to figure out where to build, and then host the required docker image(s)
 - other charts may need to include this chart
 - Multiple instances won't work correctly as port numbers are hardcoded
 - The ranger docker image hardcodes a hostname 'mariadb' which it connects to on startup - need to inject this 
 configuration for proper multi instance support
 - more ports are exposed than may be needed
 - Passwords should be pulled out to configuration (this affects ranger image itself too)
 - Look at contributing this to the Ranger project
 - Move non ranger specific charts elsewhere (ie see http://github.com/odpi/egeria)
