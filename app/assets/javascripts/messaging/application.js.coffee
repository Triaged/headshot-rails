#= require jquery
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require ./messaging

# for more details see: http://emberjs.com/guides/application/
window.Messaging = Ember.Application.create(rootElement: '#messaging', Resolver: Ember.DefaultResolver.extend(resolveTemplate: (parsedName) ->
  parsedName.fullNameWithoutType = "messaging/" + parsedName.fullNameWithoutType
  @_super parsedName
))

