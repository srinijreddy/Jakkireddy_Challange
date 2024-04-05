vpc-cidr             = "10.0.0.0/16"
public-subnet1-cidr  = "10.0.1.0/24"
public-subnet2-cidr  = "10.0.2.0/24"
key_name             = "devops"
region               = "us-east-1"
instance_type        = "t2.micro"
ami                  = "ami-0cf10cdf9fcd62d37"
env_name             = "demo"
rules = {
  # HTTPS
  https-443-tcp  = [443, 443, "tcp", "HTTPS"]

  # HTTP
  http-80-tcp   = [80, 80, "tcp", "HTTP"]

  # SSH
  ssh-tcp = [22, 22, "tcp", "SSH"]
}