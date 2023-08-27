terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.78.0"
    }
  }

  backend "gcs" {
    bucket = "b9cc05fc10e367f6-bucket-tfstate"
    prefix = "terraform/state/prod"
  }
}

