provider "kubernetes" {
  config_path = "~/.kube/config"  # path to your Minikube config
}

resource "kubernetes_namespace" "demo" {
  metadata {
    name = "demo"
  }
}

resource "kubernetes_deployment" "demo" {
  metadata {
    name      = "demo-deployment"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }
  spec {
    replicas = 2
    template {
      metadata {
        labels = {
          app = "demo-app"
        }
      }
      spec {
        container {
          image = "docker_user/demo-app:latest"  # Docker image from your registry
          name  = "demo-app"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "demo" {
  metadata {
    name      = "github-demo-service"
    namespace = kubernetes_namespace.demo.metadata[0].name
  }
  spec {
    selector = {
      app = "github-demo-project"
    }
    type = "NodePort"
    port {
      node_port   = 30001
      port        = 80
      target_port = 80
    }
  }
}
