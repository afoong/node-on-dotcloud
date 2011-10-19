#!/bin/sh

name=nodejs

packages_dir=node_modules

install_dependencies() {
    # Some user have their packages in their repository let's remove them,
    # there is good chances that we are on a different architecture anyway.
    [ -e "$packages_dir" ] && rm -rf "$packages_dir"

    # Fool npm to install packages in $HOME, this way we don't need to
    # re-install them at each push
    [ -d "$HOME/data/$packages_dir" ] || mkdir -p "$HOME/data/$packages_dir"
    ln -s "$HOME/data/$packages_dir/"

    # Finally install the specified dependencies.
    [ -f package.json ] && npm install
}

install_application() {
    rsync -aH --delete --exclude "data" * $HOME/
}

install_dependencies
install_application
