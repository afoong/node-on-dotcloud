# Custom Node.js on dotCloud

This is a custom service recipe to run *any* version of Node.js on dotCloud.
To see it in action, just clone this repository and push it to dotCloud!
To use it with your own code, copy the "nodejs" directory to your app,
and append the content of dotcloud.yml to your dotcloud.yml file.

You can set "approot" to the directory containing your Node code.
This directory should contain "server.js" and "package.json".

If you want to use a custom version of Node, just set "node_version"
as shown in the example. "node_version" is actually taken to be a
tag in the Node.js github repository. If you specify "node_version",
Node.js will be built the first time you push (it won't be rebuilt
each time, because it will be compared to "node --version"). You
can even specify "master", but in that case, Node.js will be rebuilt
at each push.

Enjoy!
