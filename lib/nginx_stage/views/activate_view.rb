require "shellwords"

module NginxStage
  # A view used as context for the activate ERB template file
  module ActivateView
    # Environment for current user used during execution of the NGINX process
    # properly escaped to be sourced by a shell
    # @return [Hash{String=>String}] the environment used to execute the NGINX
    #   process
    def nginx_env
      NginxStage.nginx_env(user: ENV["USER"]).each_with_object({}) do |(k, v), h|
        h[k.to_s] = Shellwords.escape(v.to_s) if v
      end
    end
  end
end
