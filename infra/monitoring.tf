resource "google_project_service" "monitoring" {
  service = "monitoring.googleapis.com"
}

resource "google_monitoring_notification_channel" "email" {
  display_name = "Alerta por Email"
  type         = "email"
  labels = {
    email_address = "seu@email.com" # substitua pelo seu email
  }
}

resource "google_monitoring_uptime_check_config" "website" {
  display_name = "Uptime Check - Site Estático"
  timeout      = "10s"
  period       = "60s"

  monitored_resource {
    type = "uptime_url"
    labels = {
      project_id = var.project_id
      host       = "storage.googleapis.com" # ex: storage.googleapis.com/nome-do-bucket ou www.seusite.com
    }
  }

  http_check {
  path    = "https://storage.googleapis.com/nome-unico-do-seu-bucket/site/index.html" # substitua pelo seu bucket
  port    = 443
  use_ssl = true
}

  content_matchers {
    content = "<!DOCTYPE html>"
  }

  selected_regions = ["USA", "EUROPE", "ASIA_PACIFIC"]
  # Adicione ou remova regiões conforme necessário
}

resource "google_monitoring_alert_policy" "uptime_alert" {
  display_name = "Site Offline - Alerta"

  combiner = "OR"

  conditions {
    display_name = "Uptime Check Failed"

    condition_threshold {
      filter          = "metric.type=\"monitoring.googleapis.com/uptime_check/check_passed\" AND resource.type=\"uptime_url\""
      duration        = "60s"
      comparison      = "COMPARISON_LT"
      threshold_value = 1

      aggregations {
        alignment_period     = "60s"
        per_series_aligner = "ALIGN_NEXT_OLDER"
        # Alinha os dados para o período de 60 segundos
      }
    }
  }

  notification_channels = [google_monitoring_notification_channel.email.id]
}
