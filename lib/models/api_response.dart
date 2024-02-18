class APIResponse<T>{
  var data;
  bool status;
  var message;

  APIResponse({this.data, this.status = true, this.message});
}