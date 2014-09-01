# Vagrantfile for Opps enviroment with docker containers
# Guilherme Rezende <guilhermebr@gmail.com>
# Campus Party Team

$setup = <<SCRIPT
locale-gen en_US.UTF-8
apt-get update
apt-get install -y build-essential git-core python python-dev python-setuptools
apt-get install -y postgresql-client libpq-dev
easy_install pip
pip install psycopg2
cd /app
git clone https://github.com/opps/opps.git
cd opps
python setup.py develop
SCRIPT


$containers = <<SCRIPT
# Stop and remove any existing containers
#docker stop $(docker ps -a -q)
#docker rm $(docker ps -a -q)

# Get Postgres Container (https://github.com/docker-library/postgres)
docker pull postgres:latest

# Get Redis Container (https://github.com/docker-library/redis)
docker pull redis:latest

# Get Nginx Container (https://github.com/docker-library/nginx)
docker pull nginx:latest

# Build opps base container from Dockerfiles
docker build -t opps /app/dockerfiles/opps

# Run Postgres Container
docker run -d --name opps_postgres -h "db.local" -v /var/lib/postgresql/data:/opt/postgres postgres

# Run Redis Container
docker run -d  --name opps_redis -h "redis.local" -v /opt/redis:/data redis

# To create a Container for a project:
#  cp /app/templates/Dockerfile $PROJECT_DIR
#  cp /app/templates/local_settings.py $PROJECT_FOLDER/$PROJECT_APP
#  docker build -t $PROJECT_NAME $PROJECT_DIR

# Build container Example
cd /app
./opps/opps/bin/opps-admin.py startproject example
docker build -t opps/example .

# Run and link Example container with postgres container

docker run -it --link opps_postgres:postgres --rm postgres sh -c 'createdb -h $POSTGRES_PORT_5432_TCP_ADDR -p 5432 -U postgres example'
docker run -d -p 8000:8000 --link opps_postgres:postgres --link opps_redis:redis --name opps_example -e POSTGRES_DB_NAME=example opps/example

SCRIPT

# Commands required to ensure correct docker containers
# are started when the vm is rebooted.
$start = <<SCRIPT
docker start opps_postgres
docker start opps_redis
docker start opps_example
SCRIPT

if Vagrant::VERSION < "1.6.1"
  raise "Use a newer version of Vagrant (1.6.1+)"
end

VAGRANTFILE_API_VERSION = "2"

box      = 'trusty64'
url      = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

memory   = 2048
cpus     = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config| 
  config.vm.box     = box
  config.vm.box_url = url

  # Setup resource requirements
  config.vm.provider "virtualbox" do |v|
    v.memory = memory
    v.cpus = cpus
  end

  # need a private network for NFS shares to work
  config.vm.network "private_network", ip: "192.168.50.4"

  # Django Server Port Forwarding
  config.vm.network "forwarded_port", guest: 8000, host: 8000

  # Install latest docker
  config.vm.provision "docker"

  # Must use NFS for performance
  config.vm.synced_folder ".", "/vagrant", disabled: true
  #config.vm.synced_folder ".", "/app" , type: "nfs"

  ## If having trouble with nfs:
  config.vm.synced_folder ".", "/app"


  # Setup the containers when the VM is first
  # created
  config.vm.provision "shell", inline: $setup
  config.vm.provision "shell", inline: $containers

  # Make sure the correct containers are running
  # every time we start the VM.
  config.vm.provision "shell", run: "always", inline: $start
end
