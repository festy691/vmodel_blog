class GetSingleNewsSchema {
  static String singleNewsJson = """
  query(\$blogId: String!) {
  blogPost(blogId: \$blogId) {
    id
    title
    subTitle
    body
    dateCreated
  }
}
  """;
}