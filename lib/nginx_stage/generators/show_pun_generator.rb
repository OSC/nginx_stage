module NginxStage
  # This generator shows the state of the running per-user NGINX process.
  class ShowPunGenerator < Generator
    desc 'Show the details for a given per-user nginx process'

    footer <<-EOF.gsub(/^ {4}/, '')
    Examples:
    EOF

    # Accepts 'user' as an option and validates user
    add_user_support

    # Display the chosen user
    add_hook :display_user do
      puts "User: #{user}"
    end

    # Check that pid is valid & clean up any stale files
    add_hook :check_pid_is_process do
      pid = PidFile.new pid_path
      raise StalePidFile, "stale pid file: #{pid_path}" unless pid.running_process?
      puts "Instance: #{pid}"
    end

    # Check for active sessions on Unix domain socket
    add_hook :check_socket_for_active_sessions do
      socket = SocketFile.new socket_path
      puts "Socket: #{socket}"
      puts "Sessions: #{socket.sessions}"
    end

    private
      # Path to the user's per-user NGINX pid file
      def pid_path
        NginxStage.pun_pid_path(user: user)
      end

      # Path to the user's per-user NGINX socket file
      def socket_path
        NginxStage.pun_socket_path(user: user)
      end
  end
end
