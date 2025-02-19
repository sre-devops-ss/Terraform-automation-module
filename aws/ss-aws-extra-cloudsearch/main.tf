resource "aws_opensearch_domain" "opensearch" {
  depends_on = [aws_cloudwatch_log_resource_policy.resource]
  domain_name    = var.opensearch.service
  engine_version = "OpenSearch_${var.opensearch.engine_version}"


  cluster_config {
    dedicated_master_count   = var.opensearch.dedicated_master_count
    dedicated_master_type    = var.opensearch.dedicated_master_type
    dedicated_master_enabled = var.opensearch.dedicated_master_enabled
    instance_type            = var.opensearch.instance_type
    instance_count           = var.opensearch.instance_count
    zone_awareness_enabled   = var.opensearch.zone_awareness_enabled
    zone_awareness_config {
      availability_zone_count = var.opensearch.zone_awareness_enabled ? length(var.subnet_ids) : null
    }
  }

  advanced_security_options {
    enabled                        = var.opensearch.security_options_enabled
    anonymous_auth_enabled         = false
    internal_user_database_enabled = true
    master_user_options {
      master_user_name     = var.master_user
      master_user_password = var.master_password
    }
  }


  encrypt_at_rest {
    enabled = true
  }

  domain_endpoint_options {
    enforce_https       = true
    tls_security_policy = "Policy-Min-TLS-1-2-2019-07"

    custom_endpoint_enabled         = true
    custom_endpoint                 = var.domain_details.domain
    custom_endpoint_certificate_arn = data.aws_acm_certificate.opensearch.arn
  }

  ebs_options {
    ebs_enabled = var.opensearch.ebs_enabled
    volume_size = var.opensearch.ebs_volume_size
    volume_type = var.opensearch.volume_type
    throughput  = var.opensearch.throughput
  }

  log_publishing_options {
    cloudwatch_log_group_arn = var.index_slow_logs_arn
    log_type                 = "INDEX_SLOW_LOGS"
  }
  log_publishing_options {
    cloudwatch_log_group_arn = var.search_slow_logs_arn
    log_type                 = "SEARCH_SLOW_LOGS"
  }
  log_publishing_options {
    cloudwatch_log_group_arn = var.es_application_logs_arn
    log_type                 = "ES_APPLICATION_LOGS"
  }

  node_to_node_encryption {
    enabled = true
  }
  snapshot_options {
    automated_snapshot_start_hour = var.opensearch.snapshot_hour
  }

#  vpc_options {
#    subnet_ids        =  var.opensearch.allow_public? null:var.subnet_ids
#    security_group_ids = var.opensearch.allow_public? null:[aws_security_group.opensearch_security_group.id]
#  }
  log_publishing_options {
    cloudwatch_log_group_arn = var.index_slow_logs_arn
    log_type                 = "INDEX_SLOW_LOGS"
  }
  log_publishing_options {
    cloudwatch_log_group_arn = var.search_slow_logs_arn
    log_type                 = "SEARCH_SLOW_LOGS"
  }
  log_publishing_options {
    cloudwatch_log_group_arn = var.es_application_logs_arn
    log_type                 = "ES_APPLICATION_LOGS"
  }

  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action":"es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Resource": "arn:aws:es:${var.region_name}:${var.account_id}:domain/${var.opensearch.service}/*"

        }
    ]
}
CONFIG
}
