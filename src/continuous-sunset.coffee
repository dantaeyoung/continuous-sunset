if Meteor.isClient

    # counter starts at 0
    Template.current_time.helpers
        current_time: ->
            Session.get "current_time"

if Meteor.isServer
    Meteor.startup ->


# code to run on server at startup
