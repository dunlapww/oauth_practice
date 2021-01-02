class DashboardController < ApplicationController
  def show
    conn = Faraday.new('https://api.github.com', headers: { 'Authorization': "token #{current_user.token}" })
    response = conn.get("/search/repositories?q=user:#{current_user.username}")
    data = JSON.parse(response.body, symbolize_names: true)
    @repos = {}
    @repos[:private] = []
    @repos[:public] = []
    data[:items].map do |repo|
      if repo[:private] == true
        @repos[:private] << repo[:name]
      else
        @repos[:public] << repo[:name]
      end
    end
  end
end
