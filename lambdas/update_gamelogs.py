import json

import pandas as pd


def lambda_handler(event, context):
    fake_data_for_df = {
        'pla': ['a', 'b', 'c'],
    }
    df = pd.DataFrame(fake_data_for_df)
    print(df.head())

    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
