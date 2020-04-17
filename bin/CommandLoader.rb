require_relative "CommandHandler.rb"

class CommandLoader
    COMMAND_FOLDER = File.dirname(__FILE__) + "/commands/"
    def self.load(args)
        current_command = args.shift
        all_commands = Dir["#{COMMAND_FOLDER}*"]
            .reject{ |f| File.directory? f }
            .map{ |f| File.basename f }
        
        found_command = all_commands.grep Regexp.new(current_command + "\..*")

        if (found_command.length > 0) then
            CommandHandler.new("#{COMMAND_FOLDER}#{found_command.shift}", args)
        else
            puts "Using old gdev.."
            system("gdev #{current_command}")
        end
    end
end
