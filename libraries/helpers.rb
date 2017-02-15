module LldpadCookbook
  module Helpers # :nodoc:
    def am_i_vm_guest?
      node.attribute?('virtualization') &&
        node['virtualization']['role'] == 'guest'
    end
  end
end
