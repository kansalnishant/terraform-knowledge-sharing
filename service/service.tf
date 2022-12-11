#create tomcat load balancer service
resource "kubernetes_service_v1" "tomcat_service" {
  metadata {
    name      = "deploy_tomcat"
    namespace = var.CLUSTER_NAMESPACE
    annotations = {
      "cloud.google.com/load-balancer-type" : "Internal"
    }
  }
  spec {
    type = "LoadBalancer"
    selector = {
      app = "deploy_tomcat"
    }
    port {
      port        = 8080
      target_port = 8080
    }
  }
}
