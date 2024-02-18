class DeleteNewsSchema {
  static String deleteNewsJson = """
  mutation(\$blogId: String!) {
  deleteBlog(blogId: \$blogId) {
    success
  }
}
  """;
}