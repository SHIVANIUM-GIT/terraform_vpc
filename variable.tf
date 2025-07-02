variable "region" {
  default     = "ap-sout-1"
  description = "this is aws region"
}

variable "project_name" {
  default     = "terraform"
  description = "This is the project name"
}

variable "pub_subnet" {
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "this is the public subnet cidr block"

}

variable "pri_subnet" {
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
  description = "this is the public subnet cidr block"

}

variable "cidr_block" {
  default     = "10.0.0.0/16"
  description = "this is the cidr block"

}

variable "azs" {
  default = ["ap-south-1a", "ap-south-1b"]
}