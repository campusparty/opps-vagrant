# Vagrantfile for Opps enviroment with docker containers
# Guilherme Rezende <guilhermebr@gmail.com>
# Campus Party Team

$setup = <<SCRIPT
locale-gen en_US.UTF-8
apt-get update
apt-get install -y build-essential git-core python python-dev python-setuptools
easy_install pip
cd /app
git clone https://github.com/opps/opps.git
cd opps
python setup.py develop
SCRIPT


$containers = <<SCRIPT
# Stop and remove any existing containers
#docker stop $(docker ps -a -q)
#docker rm $(docker ps -a -q)

# Build opps base container from Dockerfiles
docker build -t opps /app/dockerfiles/opps

# Build container running Example
cp /app/dockerfiles/example/Dockerfile opps/example/
docker build -t opps/example ./opps/example 

# Run and link the containers
docker run -d --name opps_postgres -e POSTGRESQL_USER=opps -e POSTGRESQL_PASS=opps postgres
docker run -d -p 8000:8000 --link opps_postgres:db --name opps_example opps/example

SCRIPT

# Commands required to ensure correct docker containers
# are started when the vm is rebooted.
$start = <<SCRIPT
docker start opps_postgres
docker start opps_example
SCRIPT

VAGRANTFILE_API_VERSION = "2"

box      = 'ubuntu/trusty64'
memory   = 2048
cpus     = 2

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config| 
  config.vm.box = box

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
