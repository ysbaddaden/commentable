class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :commentable, :polymorphic => true
      t.text       :body
#      t.references :user
      t.string     :user_name
      t.string     :user_email
      t.string     :user_url
      t.string     :user_ip,    :limit => 15
#      t.boolean    :spam
#      t.boolean    :troll
      t.timestamps
    end
    
    add_index :comments, [:commentable_type, :commentable_id]
    add_index :comments, :user_ip
#    add_index :comments, :user_id
  end

  def self.down
    drop_table :comments
  end
end
