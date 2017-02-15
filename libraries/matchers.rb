if defined?(ChefSpec)
  ChefSpec.define_matcher(:lldpad)

  def apply_lldpad(resource)
    ChefSpec::Matchers::ResourceMatcher.new(:lldpad, :apply, resource)
  end
end
