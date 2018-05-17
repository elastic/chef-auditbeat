#
# Cookbook Name:: auditbeat
# Recipe:: config
#
# Copyright 2017, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

file node['auditbeat']['conf_file'] do
  content JSON.parse(node['auditbeat']['config'].to_json).to_yaml.lines.to_a[1..-1].join
  notifies :restart, "service[#{node['auditbeat']['service']['name']}]" if node['auditbeat']['notify_restart'] && !node['auditbeat']['disable_service']
  mode 0o600
end
