module Migrations
  def trigger name
    reversible do |dir|
      dir.up do
        say_with_time("Adding trigger function on posts for updating tsv_body column") do
          sql = <<MIGRATION
             CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
             ON #{name} FOR EACH ROW EXECUTE PROCEDURE
             tsvector_update_trigger(tsv_body, 'pg_catalog.simple', alltext);
MIGRATION
          execute(sql)
        end
      end
      dir.down do
        execute("DROP TRIGGER IF EXISTS tsvectorupdate ON #{name};")
      end
    end
  end
end
