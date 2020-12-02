class Player < ApplicationRecord
    belongs_to :team
    #scope :free agent, -> { where("player.team.name == Free Agent") }



    def self.find_by_name(name)
        Player.all.find_by(name: name.titleize)
    end

    def self.create_from_api(name)
        @response = SportsData::Search.by_player(name)
        player = Player.new
        player.name = @response["Name"]
        player.nfl_team = @response["Team"]
        player.position = @response["Position"]
        player.projected_points = @response["FantasyPoints"]
        player.team_id = 1
        player.save
        player
    end

    def self.find_or_create_from_api(name)
        find_by_name(name) || create_from_api(name)
    end

    def week_projection
        self.projected_points / 17
    end

    private
    def self.by_team(team_id)
        where(team: team_id)
      end

      def self.all_except(player)
        where.not(id: player)
      end



end

