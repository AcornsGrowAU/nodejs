variable "GITHUB_RUN_NUMBER" {
  default = null
}

group "default" {
  targets = [
    "nodejs"
  ]
}

target "nodejs" {
  name = "nodejs-${tgt}-${node_version}"
  matrix = {
    node_version = [
      "18",
      "20",
    ]
    tgt = [
      "base",
      "pnpm"
    ]
  }

  target = tgt
  pull   = true
  tags = [
    "acornsaustralia/node:${tgt}-${node_version}",
    GITHUB_RUN_NUMBER != null ? "acornsaustralia/node:${node_version}-${tgt}-${GITHUB_RUN_NUMBER}" : ""
  ]
  platforms = [
    "linux/amd64"
  ]
  args = {
    "ROCKY_VERSION"    = "9"
    "NODE_VERSION"     = "${node_version}"
  }
}
