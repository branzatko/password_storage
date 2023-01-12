class WebPage {

int? id;
String url;
String username;
String password;

WebPage(this.id, this.url, this.username, this.password);

Map<String, dynamic> toMap() {
  return {
    'id': id,
    'url': url,
    'username': username,
    'password': password
  };
}
@override
String toString() {
  return 'Page{id: $id, url: $url, username: $username, password: $password}';
  }
}