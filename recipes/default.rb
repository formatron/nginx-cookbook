package 'nginx'
directory '/etc/nginx/ssl'

link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]', :delayed
end

cookbook_file '/etc/nginx/logstash.conf' do
  notifies :restart, 'service[nginx]', :delayed
end

service 'nginx' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
