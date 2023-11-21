resource "aws_ecr_repository" "nba_etl" {
  name                 = "nba-etl-repo"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}

data "archive_file" "src_code" {
  type        = "zip"
  source_dir  = "../src"
  output_path = "${path.cwd}/src_zip.zip"
}

resource "null_resource" "build_lambda_image" {
  triggers = {
    src_code_hash = "${data.archive_file.src_code.output_base64sha256}"
  }

  depends_on = [data.archive_file.src_code]

  provisioner "local-exec" {
    command = <<EOF
            aws ecr get-login-password --region ${var.region} | docker login --username AWS --password-stdin ${data.aws_caller_identity.current.account_id}.dkr.ecr.${var.region}.amazon.com
            cd ..
            docker build -t ${aws_ecr_repository.nba_etl.repository_url}:latest .
            docker push ${aws_ecr_repository.nba_etl.repository_url}:latest
        EOF
  }
}

data "aws_ecr_image" "nba_etl_image" {
  depends_on      = [null_resource.build_lambda_image]
  repository_name = aws_ecr_repository.nba_etl.name
  image_tag       = "latest"
}