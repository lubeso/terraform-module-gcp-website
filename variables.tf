variable "project" {
  type = string
}

variable "website_location" {
  type = string
}

variable "website_name" {
  type = string
}

variable "iam_member" {
  type    = string
  default = "allUsers"
}
