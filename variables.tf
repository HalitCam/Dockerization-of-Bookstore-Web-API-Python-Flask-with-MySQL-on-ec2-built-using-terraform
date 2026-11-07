variable "github_files" {
  type    = list(string)
  default = ["bookstore-api.py", "requirements.txt", "Dockerfile", "compose.yml"]
}

variable "github_token" {
  description = "GitHub token for authentication"
  type        = string
  sensitive   = true
}

variable "git_user" {
    description = "Enter the name of your github account"
    type = string
    sensitive = true
}

variable "key_name" {
  type = string
  sensitive = true
  default = "halit-key"
}
