require 'cloner'

class Dl < Cloner::Base
  no_commands do
    def rails_path
      File.expand_path("../../../config/environment", __FILE__)
    end

    def env_from
      @from
    end

    def ssh_host
      'shirykalov.ru'
    end

    def ssh_user
      'vsobake'
    end

    def pg_remote_bin_path(util)
      '/usr/lib/postgresql/10/bin/'+ util
    end

    def remote_dump_path
      "/home/#{ssh_user}/app/shared/db_backup"
    end

    def remote_app_path
      "/home/#{ssh_user}/app/current"
    end

    def verbose?
      true
    end
  end

  desc "download", "clone files and db from production"
  option :from, default: 'production'
  def download
    load_env
    @from = @options[:from]
    clone_db
  end
end
