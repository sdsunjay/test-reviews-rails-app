class AddImageColumnsToPosts < ActiveRecord::Migration
def up
    add_attachment :posts, :image
  end

  def down
    remove_attachment :posts, :imager
  end

end
