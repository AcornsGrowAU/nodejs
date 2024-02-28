variable "GITHUB_RUN_NUMBER" {}

group "default" {
  targets = [
    "nodejs"
  ]
}

target "nodejs" {
  name = "nodejs-${node_version}"
  matrix = {
    node_version = [
      "18",
      "20",
    ]
  }

  pull   = true
  tags = [
    "acornsaustralia/node:${node_version}",
    "acornsaustralia/node:${node_version}-${GITHUB_RUN_NUMBER}"
  ]
  platforms = [
    "linux/amd64"
  ]
  args = {
    "ROCKY_VERSION"    = "9"
    "NODE_VERSION"     = "${node_version}"
  }
}
