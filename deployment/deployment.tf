# deploy tomcat image
resource "kubernetes_deployment_v1" "deploy_tomcat" {
  metadata {
    name      = "deploy-tomcat"
    namespace = var.CLUSTER_NAMESPACE
    labels = {
      app = "deploy-tomcat"
    }
  }

  spec {
    selector {
      match_labels = {
        app = "deploy-tomcat"
      }
    }

    template {
      metadata {
        labels = {
          app = "deploy-tomcat"
        }
      }
      spec {
        container {
          image = "<enter the image path>"
          name  = "deploy-tomcat"
          env {
            name = "PORT"
            value = "8080"
          }
          port {
            container_port = 8080
            host_port = 8080
          }

          resources {
            limits = {
              memory = "1Gi"
            }
            requests = {
              cpu    = "100m"
              memory = "1Gi"
            }
          }
        }
      }
    }
  }
}

