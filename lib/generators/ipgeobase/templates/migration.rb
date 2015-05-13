class CreateIpgeobase < ActiveRecord::Migration
  def self.up
    create_table :ipgeobase_countries do |t|
      t.string :name
      t.string :code
    end

    create_table :ipgeobase_cities do |t|
      t.string :city
      t.string :region
      t.string :district
      t.float :lat
      t.float :lon
      t.integer :country_id
      t.foreign_key :ipgeobase_countries, column: :country_id
    end

    create_table :ipgeobase_ips, :id => false do |t|
      t.integer :start_ip, :limit => 8
      t.integer :end_ip, :limit => 8
      t.integer :city_id
      t.foreign_key :ipgeobase_cities, column: :city_id
    end

    add_index :ipgeobase_ips, [:start_ip]
    add_index :ipgeobase_ips, [:city_id], name: "index_ipgeobase_ips_on_city_id"
  end

  def self.down
    drop_table :ipgeobase_ips
    drop_table :ipgeobase_cities
    drop_table :ipgeobase_countries
  end
end
