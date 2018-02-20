module PostsHelper
  def author_id_field(post)
    if post.author.nil?
      select_tag "post[author_id]",
      options_from_collection_for_select(@authors, :id, :name)
    else
      hidden_field_tag "post[author_id]", post.author_id
    end
  end
end
