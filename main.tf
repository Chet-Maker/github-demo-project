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
    namespace = kubernetes_namespace.demo.metadata[0].name  # Corrected metadata access
  }
  spec {
    replicas = 2

    selector {  
      match_labels = {
        app = "demo-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "demo-app"
        }
      }
      spec {
        container {  # Changed from 'container' to 'containers'
          name  = "demo-app"
          image = "chetback/demo-app:latest"  # Docker image from your registry
          port {  # Changed from 'port' to 'ports'
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
    namespace = kubernetes_namespace.demo.metadata[0].name  # Corrected metadata access
  }
  spec {
    selector = {
      app = "demo-app"  # Changed to match Deployment's pod labels
    }
    type = "NodePort"
    port {  # Changed from 'port' to 'ports'
      node_port   = 30001
      port        = 80
      target_port = 80
    }
  }
}
