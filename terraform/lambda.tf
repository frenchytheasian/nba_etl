module "nba_etl_lambda" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "update_player_gamelogs"
  description   = "Updates the NBA gamelogs for all players daily"

  create_package = false

  image_uri    = "${aws_ecr_repository.nba_etl.repository_url}@${data.aws_ecr_image.nba_etl_image.id}"
  package_type = "Image"
}