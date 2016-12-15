module BadgeHunter
  class Hunter
    def run
      $stdout.puts "Hunting time!"
      $stdout.puts "\n"

      data = crawler.run

      $stdout.puts "Current monster health: #{data[:monster_health]}"

      if data[:monster_health] <= 500
        $stdout.puts 'The monster is weak, sneak around!'
      else
        $stdout.puts "The monster is too strong. Get a coffee and bide one's time.."
      end

      $stdout.puts "\n"
      $stdout.puts "Ranking:"
      $stdout.puts data[:ranking].take(3)
    end

    private

    def crawler
      @crawler ||= Crawler.new
    end
  end
end
