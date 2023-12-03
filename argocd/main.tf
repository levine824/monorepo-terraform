resource "argocd_application_set" "git_directories" {

  count = var.application_set_enabled ? 1:0

  metadata {
    name = "git-directories"
    namespace = var.argocd_namespace
  }

  spec {
    generator {
      git {
        repo_url = var.repo_url
        revision = var.revision

        directory {
          path = var.path
        }
      }
    }

    template { 
      metadata {
        name = "{{path.basename}}"
      }

      spec {
        source {
          repo_url        = var.repo_url
          target_revision = "HEAD"
          path            = "{{path}}"
        }

        destination {
          server    = "https://kubernetes.default.svc"
          namespace = var.application_namespace != "" ? var.application_namespace:"{{path.basename}}"
        }

        sync_policy {
          sync_options {
            create_namespace = "true"
          }
        }
      }
    }
  }
}