module PostsHelper
  def author_id_field(post)
    if post.author
      hidden_field_tag "post[author_id]", post.author_id
    else
      select_tag "post[author_id]", options_from_collection_for_select(Author.all, :id, :name)
    end
  end
end
