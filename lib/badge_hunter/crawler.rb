require 'yaml'
require 'pry'

module BadgeHunter
  class Crawler
    include Capybara::DSL
    include Capybara::Angular::DSL

    attr_reader :data, :logged_in

    def initialize
      @data = {}
      @logged_in = false
    end

    def run
      reset!
      log_in
      collect_data
    end

    private

    def reset!
      data.clear
      @logged_in = false
      page.reset!
    end

    def collect_data
      {
        monster_health: fetch_monster_health,
        ranking: fetch_ranking
      }
    end

    def log_in
      visit 'https://getbadges.io/login'

      fill_in 'Username', with: ENV['GETBADGES_USERNAME']
      fill_in 'Password', with: ENV['GETBADGES_PASSWORD']

      click_on 'Login'

      @logged_in = true
    end

    def fetch_monster_health
      visit_dashboard :activity

      selector_for(:monster_health)
        .text.split('/').first.strip.to_i
    end

    def fetch_ranking
      visit_dashboard :leaderboard

      selector_for(:ranking)
        .all(:css, "li.lead")
        .map { |lead| lead.find "a" }
        .map(&:text)
    end

    def visit_dashboard(name)
      find(:xpath, "//a[@href='/#{name.to_s}']").click
      wait_until_angular_ready
    end

    def selector_for(name)
      first :xpath, selectors[name.to_s]
    end

    def selectors
      @selectors ||= YAML.load_file selectors_path
    end

    def selectors_path
      File.expand_path '../../selectors.yml', __FILE__
    end
  end
end
