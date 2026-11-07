# Github Repository Config
resource "github_repository" "repo_bookstore" {
  name        = "dockerization-bookstore-app"
  description = "My awesome codebase"
  auto_init   = true
  visibility  = "public"
  #   default_branch = "main"
}

resource "github_branch_default" "branch_default" {
  repository = github_repository.repo_bookstore.name
  branch     = "main"
}

resource "github_repository_file" "github_file" {
  repository          = github_repository.repo_bookstore.name
  branch              = "main"
  for_each            = toset(var.github_files)
  file                = each.value
  content             = file("${path.module}/${each.value}")
  commit_message      = "New file added"
  overwrite_on_create = true
}

# Creating Services on AWS Provider

locals {
  instance_name = "tf-docker-ec2"
}

resource "aws_security_group" "tf-docer-sec-grp" {
  name        = "${local.instance_name}-sec-grp"
  description = "Allow 22 and 80 ports all inbound traffic and all outbound traffic"

  tags = {
    Name = "${local.instance_name}-sec-grp"
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "tf-docker-ec2" {
  ami             = data.aws_ami.tf-docker-ec2-ami.id
  instance_type   = "t3.small"
  user_data       = templatefile("${path.module}/userdata.sh", {TOKEN = var.github_token, GIT_USER = var.git_user})
  vpc_security_group_ids = [ aws_security_group.tf-docer-sec-grp.id]
  key_name = var.key_name

  tags = {
    Name = "${local.instance_name}"
  }
}





