import os
from pathlib import Path

import pandas as pd
from nba_api.stats.endpoints import playergamelog
from nba_api.stats.library.parameters import Season


def get_player_gamelogs():
    data_dir = Path(os.getcwd()).parent.parent / "Data" / "nba_data"
    players = pd.read_csv(data_dir / "current_players.csv")
    ids = players["PERSON_ID"].tolist()

    for id in ids:
        print(f"Getting gamelogs for {id}")
        player_gamelog = pd.concat(
            playergamelog.PlayerGameLog(
                player_id=id, season=Season.current_season
            ).get_data_frames()
        )
        season_dir = data_dir / Season.current_season
        if not season_dir.exists():
            season_dir.mkdir()
        player_gamelog.to_parquet(data_dir / Season.current_season / f"{id}.parquet")


if __name__ == "__main__":
    get_player_gamelogs()
