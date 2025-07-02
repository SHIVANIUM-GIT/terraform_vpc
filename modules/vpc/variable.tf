variable "project_name" {
  default     = "terraform"
  description = "This is the project name"
}

variable "cidr_block" {
  description = "cidr block"
  default = "10.0.0.0/16"
  
}

variable "pub_subnet" {
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  description = "this is the public subnet cidr block"

}

variable "pri_subnet" {
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
  description = "this is the public subnet cidr block"

}

variable "azs" {
  description = "Availability zones"
  type        = list(string)
}