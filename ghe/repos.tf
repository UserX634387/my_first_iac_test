resource "github_repository" "ghemanager_repo" {
  name             = "${var.ghe_organization}-ghemanager"
  visibility       = "private"
  license_template = "mit"
  auto_init        = "false"
}

resource "github_repository_file" "upload-ghe-project" {
  repository = github_repository.ghemanager_repo.name
  for_each   = fileset(path.module, "*.{tf,md}")
  file       = each.key
  content    = file(each.value)
  branch     = "main"
  depends_on = [
    github_repository.ghemanager_repo
  ]
}

resource "github_repository" "tfemanager_repo" {
  name             = "${var.ghe_organization}-tfemanager"
  visibility       = "private"
  license_template = "mit"
  auto_init        = "false"
  depends_on = [
    github_repository_file.upload-ghe-project
  ]
}
