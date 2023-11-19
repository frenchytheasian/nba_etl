module "nba_etl_lambda" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "update_player_gamelogs"
  description   = "Updates the NBA gamelogs for all players daily"
  runtime       = "python3.12"
  handler       = "update_gamelogs.lambda_handler"
  source_path   = "../lambdas"
}