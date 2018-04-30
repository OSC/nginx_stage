module NginxStage
  # This generator outputs a file that can be sourced by the shell to have a
  # similar environment as a per-user NGINX environment
  class ActivateGenerator < Generator
    desc 'Output a shell script with same enviroment as per-user nginx process'

    footer <<-EOF.gsub(/^ {4}/, '')
    Examples:
        To get the environment of **your** per-user nginx process:

            nginx_stage activate

        this outputs a script that can be sourced by the shell.
    EOF

    include ActivateView

    # Output script with per-user NGINX environment that can be sourced
    add_hook :output_script do
      puts render(File.read File.join(NginxStage.template_root, "activate.erb"))
    end
  end
end
