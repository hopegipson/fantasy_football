class GamesController < ApplicationController
  before_action :free_agent_team
  before_action :find_game, only: [:show, :edit, :update]
  before_action :logged_in?


      def show
        @home_team = @game.home_team
        @visitor_team = @game.visitor_team
        @home_players = @home_team.players
        @visitor_players = @visitor_team.players
        @week = @game.competition.game_week
      end

      def edit
        if admin? == false
          flash[:errors ]= ["Only an admin can score a game."]
          redirect_to game_path(@game)
        elsif teams_full?
          @home_team = @game.home_team
          @visitor_team = @game.visitor_team
          @home_players = @home_team.players
          @visitor_players = @visitor_team.players
          @week = @game.competition.game_week
        else
          flash[:errors ]= ["This game cannot be scored until both teams have played a full lineup."]
          redirect_to game_path(@game)
        end
      end

      def update
        @game.update(game_params)
        @game.scored = true
        @game.total_score
        @game.choose_winner
        @game.save
        flash[:messages ]= ["Game scores updated"]
        redirect_to game_path(@game)
    end



    private

    def find_game
      @game = Game.find_by(id: params[:id])
    end

    def game_params
      params.require(:game).permit(:team1_player1_score, :team1_player2_score, :team1_player3_score, :team1_player4_score, :team1_player5_score, :team1_player6_score, :team1_player7_score, :team2_player1_score, :team2_player2_score, :team2_player3_score, :team2_player4_score, :team2_player5_score, :team2_player6_score, :team2_player7_score)
    end

    def teams_full?
      @game.home_team.players.count == 7 && @game.visitor_team.players.count == 7
    end
end
