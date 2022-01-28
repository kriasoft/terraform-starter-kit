# Cloudflare DNS Records
# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs

resource "cloudflare_record" "a" {
  zone_id = cloudflare_zone.default.id
  name    = local.hostname
  value   = "192.0.2.1"
  type    = "A"
  ttl     = 1
  proxied = true
}

resource "cloudflare_record" "cname_www" {
  zone_id = cloudflare_zone.default.id
  name    = "www"
  value   = local.hostname
  type    = "CNAME"
  ttl     = 1
  proxied = true
}
