provider "aws" {
    region = "us-west-2"
}

resource "aws_instance" "example" {
    ami           = "ami-0c94855ba95c71c99"
    instance_type = "t2.micro"

    tags = {
        Name = "example-instance"
    }
}

resource "aws_ecr_repository" "example_ecr" {
    name = "example-ecr-repo"
}

resource "aws_ecr_image" "example_image" {
    name         = aws_ecr_repository.example_ecr.repository_url
    image_tag    = "latest"
    image_scanning_configuration {
        scan_on_push = true
    }
}

output "ecr_repository_uri" {
    value = aws_ecr_repository.example_ecr.repository_url
}