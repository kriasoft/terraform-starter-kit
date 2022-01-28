# Cloudflare DNS Zone
# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs

resource "cloudflare_zone" "default" {
  zone = local.domain
  plan = "free"
}

resource "cloudflare_zone_settings_override" "default" {
  zone_id = cloudflare_zone.default.id

  # https://api.cloudflare.com/#zone-settings-properties
  settings {
    always_online = "on"
    # advanced_ddos = "on"
    brotli            = "on"
    browser_cache_ttl = 14400
    browser_check     = "on"
    # cname_flattening = "flatten_at_root"
    cache_level      = "aggressive"
    challenge_ttl    = 1800
    development_mode = "off"
    early_hints      = "off"
    # edge_cache_ttl = 7200
    # origin_error_page_pass_thru = "off"
    # sort_query_string_for_cache = "off"
    email_obfuscation  = "on"
    hotlink_protection = "off"
    ip_geolocation     = "on"
    ipv6               = "on"
    websockets         = "on"

    minify {
      css  = "off"
      js   = "off"
      html = "off"
    }

    max_upload = 100

    # mobile_redirect {
    #   status           = "off"
    #   mobile_subdomain = "m"
    #   strip_uri        = false
    # }

    # mirage = "off"
    # polish = "off"
    # webp = "off"
    # prefetch_preload = "off"
    privacy_pass = "on"
    # response_buffering = "off"
    rocket_loader = "off"

    # security_header {
    #   enabled            = false
    #   preload            = false
    #   max_age            = 86400
    #   include_subdomains = true
    #   nosniff            = true
    # }

    security_level      = "medium"
    server_side_exclude = "on"
    ssl                 = "flexible"
    tls_client_auth     = "on"
    # true_client_ip_header = "on"
    # proxy_read_timeout = 100
    # waf = "off"
    min_tls_version          = "1.0"
    ciphers                  = []
    opportunistic_encryption = "on"
    automatic_https_rewrites = "on"
    # http2 = "on"
    http3    = "on"
    zero_rtt = "off"
    # visitor_ip = "on" # pseudo_ipv4
    always_use_https    = "on"
    opportunistic_onion = "on"
    # orange_to_orange = "on"
    # image_resizing = "off"
    h2_prioritization = "off"
  }
}
