module "nba_etl_lambda" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "update_player_gamelogs"
  description   = "Updates the NBA gamelogs for all players daily"
  runtime       = "python3.12"
  handler       = "update_gamelogs.lambda_handler"
  source_path   = "../lambdas"
}

module "nba_etl_dependencies" {
  source = "terraform-aws-modules/lambda/aws"

  create_layer = true

  layer_name          = "nba_etl_dependencies"
  description         = "Python dependencies for the NBA ETL lambda"
  compatible_runtimes = ["python3.12"]

  source_path = "../packages"
}