# TypesAndInitializerBug

Demonstrating a bug between initializer and dry types:

```
$ rspec spec

TypesAndInitializerBug
  TypesAndInitializerBug::Broken
    loads the inited fine (FAILED - 1)
  TypesAndInitializerBug::Wrapped
    loads the inited fine

Failures:

  1) TypesAndInitializerBug TypesAndInitializerBug::Broken loads the inited fine
     Failure/Error: TypesAndInitializerBug::Broken.new

     TypeError:
       #<TypesAndInitializerBug::Broken:0x00007f8f5a9e4be8> is not a symbol nor a string
     # /Users/kchoubacha/.rvm/gems/ruby-2.4.2/gems/dry-types-0.12.1/lib/dry/types/array/member.rb:20:in `block in call'
     # /Users/kchoubacha/.rvm/gems/ruby-2.4.2/gems/dry-types-0.12.1/lib/dry/types/array/member.rb:20:in `map'
     # /Users/kchoubacha/.rvm/gems/ruby-2.4.2/gems/dry-types-0.12.1/lib/dry/types/array/member.rb:20:in `call'
     # (eval):6:in `__dry_initializer_initialize__'
     # /Users/kchoubacha/.rvm/gems/ruby-2.4.2/gems/dry-initializer-2.3.0/lib/dry/initializer/mixin/root.rb:7:in `initialize'
     # ./spec/types_and_initializer_bug_spec.rb:6:in `new'
     # ./spec/types_and_initializer_bug_spec.rb:6:in `block (3 levels) in <top (required)>'

Finished in 0.00154 seconds (files took 0.19051 seconds to load)
2 examples, 1 failure

Failed examples:

rspec ./spec/types_and_initializer_bug_spec.rb:5 # TypesAndInitializerBug TypesAndInitializerBug::Broken loads the inited fine
```

This appears to be because initializer now looks for arity and passes `self` as the second param:
https://github.com/dry-rb/dry-initializer/blob/7a605f2a5421747f99299b610fbbc85f801d75e3/lib/dry/initializer/builders/attribute.rb#L69-L73

But dry types array.member uses a second param to control the method call:
https://github.com/dry-rb/dry-types/blob/506b7588a7b776cd59e2e27538256472e4c8d3df/lib/dry/types/array/member.rb#L19-L21

This causes the above spec failure.
