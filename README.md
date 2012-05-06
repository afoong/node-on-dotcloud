# Custom Node.js on dotCloud

This is a custom service recipe to run *any* version of Node.js on dotCloud.
To see it in action, just clone this repository and push it to dotCloud!

## Use it with your own code:

1. Copy the "nodejs" directory to your app  
2. Append or merge the content of dotcloud.yml to your dotcloud.yml file.  

## dotcloud.yml

* You can set "approot" to the directory containing your Node code.
    * This directory should contain "server.js" and "package.json".

* If you want to use a custom version of Node, just set "node_version"
as shown in the example. 
    * "node_version" is actually taken to be a tag in the Node.js github repository.
    
* If you specify "node_version", Node.js will be built the first time you push 
    * (it won't be rebuilt each time, because it will be compared to "node --version"). 
    * You can even specify "master", but in that case, Node.js will be rebuilt at each push.

3. Tell your nodejs app to listen on the port dotcloud has assigned to you.

* It is an environement variable listed in the 'environment.json' file that is located in your dotcloud home directory.

    app.listen(process.env['PORT_WWW'] || 8080);

Enjoy!

## Examples

### dotcloud.yml
e.g. if your current dotcloud.yml looks like this:  

    www:  
      type: nodejs  
      approot: hellonode # change this to your application root!s    
      node_version: v0.4.5  
      environment:  
        NODE_ENV: production  

you should have something like this to use the custom node app:  

    www:  
      type: custom  
      buildscript: nodejs/builder  
      ports:  
        www: http  
      process: node server.js  
      approot: hellonode # change this to your application root!s  
      node_version: v0.6.15  
      environment:  
        NODE_ENV: production  
        
**Note:** Whatever your previous service node service name was (www in the example),   
should now be a custom app. Any app that needs to use a custom version of nodejs will need to be a custom app with buildscript.

## Possible Issues

### Supervisorctl

If you see erros like this

    Error: .ini file does not include supervisorctl section
    For help, use /usr/bin/supervisorctl -h
    
You may need to specify a \[supervisorctl\] section in your *supervisord.conf*

#### Example

    [program:node] 
    environment = NODE_ENV=production 
    command = node server.js
    directory = /dotcloud/path/to/approot

    [supervisorctl]
    serverurl = unix:///var/dotcloud/supervisor.sock
    
**Note:** *supervisor.sock* may be listed in another location. SSH in and find it if that does not work.




