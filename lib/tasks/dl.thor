require 'cloner'

class Dl < Cloner::Base
  no_commands do
    def rails_path
      File.expand_path("../../../config/environment", __FILE__)
    end
    def ssh_host
      '52.41.205.115'
    end
    def ssh_user
      'clonclient'
    end
    def remote_dump_path
      '/home/clonclient/tmp_dump'
    end
    def remote_app_path
      '/home/clonclient/app/current'
    end
  end

  desc "download", "clone files and DB from production"
  def download
    load_env
    clone_db
    rsync_public("system")
  end
end

