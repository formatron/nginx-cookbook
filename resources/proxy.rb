actions :create
default_action :create

attribute :hostname, name_attribute: true, kind_of: String, required: true
attribute :port, kind_of: Fixnum, required: true
attribute :ssl_cert, kind_of: String, required: true
attribute :ssl_key, kind_of: String, required: true
