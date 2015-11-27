def whyrun_supported?
  true
end

use_inline_resources

def resolve_address(hostname)
  ::Resolv.getaddress hostname
rescue
  hostname
end

action :create do
  hostname = new_resource.hostname
  port = new_resource.port
  ip = resolve_address hostname
  ssl_key = "/etc/nginx/ssl/#{hostname}.key"
  ssl_cert = "/etc/nginx/ssl/#{hostname}.crt"
  file ssl_key do
    content new_resource.ssl_key
  end
  file ssl_cert do
    content new_resource.ssl_cert
  end
  template "/etc/nginx/sites-available/#{hostname}" do
    cookbook 'formatron_nginx'
    source 'proxy.erb'
    variables(
      hostname: hostname,
      ip: ip,
      port: port,
      ssl_cert: ssl_cert,
      ssl_key: ssl_key
    )
  end
  link "/etc/nginx/sites-enabled/#{hostname}" do
    to "/etc/nginx/sites-available/#{hostname}"
  end
end
