# Sample plugin migration
# Use rake db:migrate_plugins to migrate installed plugins
class CreateAnnouncements < ActiveRecord::Migration
  def self.up
    create_table :announcements do |t|
      t.text :message
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end

  def self.down
    drop_table :announcements
  end
end

