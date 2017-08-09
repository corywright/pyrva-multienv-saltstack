# pyrva-multienv-saltstack

PyRVA - Multi-Environment SaltStack with Python

[Google Slides](https://bit.ly/pyrva-mess-slides)

## Installation Steps

Install the `salt-master` package, and create a `salt` user. Switch to the `salt` user and  clone this repository:

    adduser salt
    su - salt
    git clone https://github.com/corywright/pyrva-multienv-saltstack.git
    exit
    
    # now as root symlink the files, pillar, and states
    ln -s /home/salt/pyrva-multienv-saltstack/states /srv/salt
    ln -s /home/salt/pyrva-multienv-saltstack/pillar /srv/pillar
    ln -s /home/salt/pyrva-multienv-saltstack/files /srv/files
    
    apt-get install salt-master
    