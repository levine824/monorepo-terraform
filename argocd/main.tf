resource "argocd_application_set" "git_directories" {
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
          namespace = var.namespace != "" ? var.namespace:"{{path.basename}}"
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