def whyrun_supported?
  true
end

use_inline_resources

action :create do
  ssl_key = "/etc/nginx/ssl/#{new_resource.hostname}.key"
  ssl_cert = "/etc/nginx/ssl/#{new_resource.hostname}.crt"
  file ssl_key do
    content new_resource.ssl_key
  end
  file ssl_cert do
    content new_resource.ssl_cert
  end
  template "/etc/nginx/sites-available/#{new_resource.hostname}" do
    cookbook 'formatron_nginx'
    source 'proxy.erb'
    variables(
      hostname: "#{new_resource.hostname}",
      port: new_resource.port,
      ssl_cert: ssl_cert,
      ssl_key: ssl_key
    )
  end
  link "/etc/nginx/sites-enabled/#{new_resource.hostname}" do
    to "/etc/nginx/sites-available/#{new_resource.hostname}"
  end
end
