**Stack**

Chef solo recipes for that sets up:

- Nginx
- Unicorn
- Postgres
- rbenv to manage rubies

**Usage**

0. Copy `ip.example` to `ip` and paste in browser ip address
1. `./setup.sh` installs base ruby, build dependencies and Chef.
2. Copy `node.json.example` to `node.json` and customize it to your needs
3. Initialize git submodules
4. `./sync.sh` syncs the chef recipes to the server.
5. `./update.sh` installs packages via chef.

** Tested on

- Ubuntu 12.04 x64
