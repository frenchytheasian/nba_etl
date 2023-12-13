from datetime import datetime

import pandas as pd
from nba_api.stats.endpoints import scoreboardv2, boxscoretraditionalv3
from nba_api.stats.library.parameters import DayOffset

def _get_box_score_for_game(game_id: str) -> pd.DataFrame:
    box_score_results = boxscoretraditionalv3.BoxScoreTraditionalV3(game_id=game_id)
    return box_score_results.get_data_frames()[0]


def lambda_handler(event, context):
    scoreboard_results = scoreboardv2.ScoreboardV2(day_offset=-1)
    game_header_df = scoreboard_results.game_header.get_data_frame()

    games_done = (game_header_df["GAME_STATUS_TEXT"] == "Final").all()
    if not games_done:
        raise ValueError("Not all games are done yet")

    game_ids = game_header_df["GAME_ID"].to_list()

    box_scores = []
    for game_id in game_ids:
        box_scores.append(_get_box_score_for_game(game_id))
    
    return pd.concat(box_scores, ignore_index=True)
