class CommandHandler
    def initialize(command_file, args)
        read_file(command_file, args)
    end

    def handle_command(line)
        return system(line)
    end

    def evaluate(eval_container)
        eval(eval_container)
    end

    def read_file(command_file, args)
        case File.extname(command_file)
        when ".rb"
            file = File.open(command_file, "r")
            eval_container = "args = #{args}\n"
            eval_container << file.read
            evaluate(eval_container)
        when ".py"
            handle_command("python #{command_file}")
        when ".sh"
            handle_command("bash #{command_file}")
        else
            puts command_file
            puts "Could not understand script format!"
        end
    end
end