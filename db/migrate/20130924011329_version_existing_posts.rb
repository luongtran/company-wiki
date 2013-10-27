class VersionExistingPosts < ActiveRecord::Migration
  def change
    say_with_time "Setting initial version for posts" do
      Post.find_each(&:touch)
    end
  end
end
