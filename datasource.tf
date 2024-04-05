data "template_file" "userdata_content" {
  template = file("index.html")
}