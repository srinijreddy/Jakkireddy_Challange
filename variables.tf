
#Env naming
variable "env_name" {
  default = "poc"
  type    = string
}

#AMI 
variable "ami" {
  default     = "ami-0e4d9ed95865f3b40"
  description = "AMI"
  type        = string
}

#Instance Type
variable "instance_type" {
  default     = "t2.micro"
  description = "instance_type"
  type        = string
}

# Region 
variable "region" {
  description = "Region"
  type        = string
}

#VPC CIDR 
variable "vpc-cidr" {
  default     = "10.0.0.0/16"
  description = "vpc cidr block"
  type        = string
}

#Public SubNet
variable "public-subnet1-cidr" {
  default     = "10.0.1.0/24"
  description = "Public Subnet 1 CIDR block"
  type        = string
}

variable "public-subnet2-cidr" {
  default     = "10.0.2.0/24"
  description = "Public Subnet 2 CIDR block"
  type        = string
}

variable "rules" {
  description = "Map of known security group rules (define as 'name' = ['from port', 'to port', 'protocol', 'description'])"
  type        = map(list(any))
}

variable "key_name" {
  type        = string
  description = "Key pair name"
}
