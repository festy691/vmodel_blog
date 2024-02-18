class GetAllNewsSchema {
  static String allNewsJson = """
  query {
  allBlogPosts {
    id
    title
    subTitle
    body
    dateCreated
  }
}
  """;
}