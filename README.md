**Stack**

Chef solo recipes for `Ubuntu 12.04 LTS 32 bit` that sets up

- Nginx
- Unicorn
- Postgres
- rbenv to manage rubies
- Foreman for process management via Upstart

**Usage**

0. Copy `ip.example` to `ip` and paste in browser ip address
1. `./setup.sh` installs base ruby, build dependencies and Chef.
2. Copy `node.json.example` to `node.json` and customize it to your needs
2. `./sync.sh` syncs the chef recipes to the server.
3. `./update.sh` installs packages via chef.
