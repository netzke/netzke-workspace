# Let's imagine that loading HelloUser component should not be allowed.
# SecureTabPanel makes a security check on what component is being requested, and returns a different component if
# the check doesn't pass.
class SecureTabPanel < SomeTabPanel
  component :tab do |c|
    super c
    if c.klass == HelloUser # class check
      c.klass = Netzke::Core::Panel
      c.title = 'HelloUser not allowed'
    end
  end
end
