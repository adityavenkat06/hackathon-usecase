terraform {
  backend "gcs" {
    bucket = "tf-state-hackathon"
    prefix = "envs/dev"
  }
}
