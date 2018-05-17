if node['platform'] == 'windows' # ~FC023
  powershell_script 'install auditbeat as service' do
    code "& '#{node['auditbeat']['conf_dir']}/install-service-auditbeat.ps1'"
  end
end

ruby_block 'delay auditbeat service start' do
  block do
  end
  notifies :start, "service[#{node['auditbeat']['service']['name']}]"
  not_if { node['auditbeat']['disable_service'] }
end

service_action = node['auditbeat']['disable_service'] ? %i[disable stop] : %i[enable nothing]

service node['auditbeat']['service']['name'] do
  provider Chef::Provider::Service::Solaris if node['platform_family'] == 'solaris2'
  retries node['auditbeat']['service']['retries']
  retry_delay node['auditbeat']['service']['retry_delay']
  supports :status => true, :restart => true
  action service_action
end
