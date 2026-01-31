variable "project_id" {
  type    = string
  default = "project-d4826681-abb0-48b5-a98"
}

variable "region" {
  type    = string
  default = "asia-south1"
}

variable "zones" {
  type    = list(string)
  default = ["asia-south1-a"]
}
